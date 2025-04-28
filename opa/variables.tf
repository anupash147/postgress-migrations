# variables.tf
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "bucket_name_prefix" {
  description = "Prefix for the S3 bucket name"
  type        = string
  default     = "terraform-workspace-demo"
}

# outputs.tf
output "bucket_name" {
  value = aws_s3_bucket.example.id
}

output "workspace_name" {
  value = terraform.workspace
}
