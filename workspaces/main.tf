# main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "test-iac-sbx"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

# Generate a random suffix for unique bucket names
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

# S3 bucket with workspace-specific configuration
# Create an S3 bucket with different configurations per workspace
resource "aws_s3_bucket" "example" {
  bucket = "${random_string.suffix.result}-${terraform.workspace}"

  tags = {
    Environment = terraform.workspace
  }
}



# variables.tf
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

# locals.tf
locals {
  # Workspace-specific configurations
  workspace_configs = {
    default = {
      bucket_prefix     = "demo-default"
      enable_versioning = false
      tags = {
        Purpose = "Testing"
      }
    }
    dev = {
      bucket_prefix     = "demo-dev"
      enable_versioning = false
      tags = {
        Purpose = "Development"
      }
    }
    staging = {
      bucket_prefix     = "demo-staging"
      enable_versioning = true
      tags = {
        Purpose = "Staging"
      }
    }
    prod = {
      bucket_prefix     = "demo-prod"
      enable_versioning = true
      tags = {
        Purpose     = "Production"
        CostCenter = "123456"
      }
    }
  }

    # Get configuration for current workspace
  }

# outputs.tf
output "bucket_name" {
  value = aws_s3_bucket.example.id
}

output "workspace_name" {
  value = terraform.workspace
}