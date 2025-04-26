terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-2" # or your desired region
}


# VPC Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "postgres-vpc"
  cidr = "10.0.0.0/16"

  azs              = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets   = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnets = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true


  tags = {
    Environment = "dev"
    Project     = "postgres-migration"
  }
}

# Get current public IP
data "http" "my_ip" {
  url = "https://ipv4.icanhazip.com"
}

# Security Group for RDS
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "postgres-sg"
  description = "Security group for PostgreSQL RDS"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from specific IP"
      cidr_blocks = "${chomp(data.http.my_ip.response_body)}/32"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Environment = "dev"
    Project     = "postgres-migration"
  }
}


# Create an alias for the KMS key
resource "aws_kms_alias" "rds" {
  name          = "alias/postgres-rds-key"
  target_key_id = aws_kms_key.rds.key_id
}

# Update the RDS module to use the custom KMS key
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = "postgres-rds"

  engine               = "postgres"
  engine_version       = "16.7"       # Latest available version
  family               = "postgres16" # PostgreSQL 16 parameter group family
  major_engine_version = "16"
  instance_class       = "db.t3.micro"

  allocated_storage = 20
  storage_encrypted = true
  kms_key_id        = aws_kms_key.rds.arn
  storage_type      = "gp3"

  db_name  = "mydb"
  username = "dbadmin"
  port     = 5432
  password = var.db_password

  multi_az               = false
  db_subnet_group_name   = module.vpc.database_subnet_group_name
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 7

  skip_final_snapshot = true

  parameters = [
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]

  tags = {
    Environment = "dev"
    Project     = "postgres-migration"
  }
}


# Get current AWS account ID
data "aws_caller_identity" "current" {}

# Add outputs for KMS key information
output "kms_key_id" {
  description = "The ID of the KMS key used for RDS encryption"
  value       = aws_kms_key.rds.id
}

output "kms_key_arn" {
  description = "The ARN of the KMS key used for RDS encryption"
  value       = aws_kms_key.rds.arn
}

output "kms_key_alias" {
  description = "The alias of the KMS key used for RDS encryption"
  value       = aws_kms_alias.rds.name
}

# Variables
variable "db_password" {
  description = "Password for the RDS postgres instance"
  type        = string
  sensitive   = true
}
variable "kms_key_deletion_window" {
  description = "Duration in days after which the key is deleted after destruction of the resource"
  type        = number
  default     = 7
}

variable "kms_key_enable_rotation" {
  description = "Specifies whether key rotation is enabled"
  type        = bool
  default     = true
}

variable "kms_admin_roles" {
  description = "List of IAM roles that should have admin access to the KMS key"
  type        = list(string)
  default     = []
}

# Variables for database connections
variable "source_db" {
  description = "Source database connection information"
  type = object({
    host     = string
    port     = number
    name     = string
    username = string
    password = string
  })
  sensitive = true
}

# Create KMS Key with enhanced policy and tags
resource "aws_kms_key" "rds" {
  description             = "KMS key for RDS database encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  multi_region            = false # Set to true if you need multi-region key

  tags = {
    Environment = "dev"
    Project     = "postgres-migration"
    Name        = "postgres-rds-encryption-key"
    ManagedBy   = "terraform"
  }

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow RDS to use the key"
        Effect = "Allow"
        Principal = {
          Service = ["rds.amazonaws.com"]
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:CreateGrant",
          "kms:ListGrants",
          "kms:DescribeKey"
        ]
        Resource = "*"
      }
    ]
  })
}

# Add monitoring for the KMS key
resource "aws_cloudwatch_metric_alarm" "kms_key_usage" {
  alarm_name          = "kms-key-usage-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "KeyUsage"
  namespace           = "AWS/KMS"
  period              = "300"
  statistic           = "Sum"
  threshold           = "1000"
  alarm_description   = "This metric monitors KMS key usage"
  alarm_actions       = [] # Add SNS topic ARN if needed

  dimensions = {
    KeyId = aws_kms_key.rds.id
  }

  tags = {
    Environment = "dev"
    Project     = "postgres-migration"
  }
}


# Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.vpc.database_subnets
}

output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = module.db.db_instance_endpoint
}

output "rds_port" {
  description = "The port the RDS instance is listening on"
  value       = module.db.db_instance_port
}

output "database_subnet_group_name" {
  description = "Name of database subnet group"
  value       = module.vpc.database_subnet_group_name
}


# Null resource to test RDS connection
resource "null_resource" "test_connection" {
  depends_on = [module.db]

  provisioner "local-exec" {
    command = <<-EOF
      echo "Testing RDS Connection..."
      echo "Host: ${module.db.db_instance_address}"
      echo "Database: ${module.db.db_instance_name}"
      echo "User: ${module.db.db_instance_username}"
      
      # Wait for RDS to be fully available
      echo "Waiting for RDS to be fully available..."
      sleep 30

      # Test TCP connection
      echo "Testing TCP connection..."
      nc -zv ${module.db.db_instance_address} 5432
      TCP_RESULT=$?
      
      if [ $TCP_RESULT -eq 0 ]; then
        echo "TCP connection successful"
        
        # Test PostgreSQL connection
        echo "Testing PostgreSQL connection..."
        PGPASSWORD='${var.db_password}' psql -h ${module.db.db_instance_address} \
          -p 5432 \
          -U ${module.db.db_instance_username} \
          -d ${module.db.db_instance_name} \
          -c "SELECT version();" 2>&1
        PSQL_RESULT=$?
        
        if [ $PSQL_RESULT -eq 0 ]; then
          echo "PostgreSQL connection successful"
        else
          echo "PostgreSQL connection failed"
          exit 1
        fi
      else
        echo "TCP connection failed"
        exit 1
      fi
    EOF

    interpreter = ["/bin/bash", "-c"]

    environment = {
      PGPASSWORD = var.db_password
    }
  }

  # Trigger the test on changes to these attributes
  triggers = {
    instance_address = module.db.db_instance_address
    endpoint         = module.db.db_instance_endpoint
    username        = module.db.db_instance_username
    name            = module.db.db_instance_name
  }
}

# Output the connection details
output "connection_command" {
  description = "Command to connect to the PostgreSQL database"
  value       = "PGPASSWORD='<your-password>' psql -h ${module.db.db_instance_address} -U ${module.db.db_instance_username} -d ${module.db.db_instance_name}"
  sensitive   = false
}

output "connection_string" {
  description = "PostgreSQL connection string"
  value       = "postgresql://${module.db.db_instance_username}:@${module.db.db_instance_address}/${module.db.db_instance_name}"
  sensitive   = false
}

