# main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Create an S3 bucket with different configurations per workspace
resource "aws_s3_bucket" "example" {
  bucket = "${var.bucket_name_prefix}-${terraform.workspace}"

}

# Enable versioning only in prod workspace
resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.example.id
  
  versioning_configuration {
    status = terraform.workspace == "prod" ? "Enabled" : "Disabled"
  }
}
