resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.0"

  identifier = "${var.environment}-postgres-rds"

  engine               = "postgres"
  engine_version       = "16.7"
  family              = "postgres16"
  major_engine_version = "16"
  instance_class       = var.rds_instance_class

  allocated_storage = var.rds_allocated_storage
  storage_encrypted = true
  storage_type      = "gp3"

  db_name  = var.source_database_name
  username = "dbadmin"
  password = random_password.rds_password.result
  port     = 5432

  multi_az               = false
  db_subnet_group_name   = module.vpc.database_subnet_group_name
  vpc_security_group_ids = [aws_security_group.rds.id]

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

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      Project     = "postgres-migration"
    }
  )
}
