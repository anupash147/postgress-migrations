output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = module.rds.db_instance_endpoint
}

output "rds_instance_identifier" {
  description = "The RDS instance identifier"
  value       = module.rds.db_instance_identifier
}

output "rds_port" {
  description = "The RDS instance port"
  value       = module.rds.db_instance_port
}

output "rds_username" {
  description = "The RDS instance master username"
  value       = module.rds.db_instance_username
}

output "rds_password" {
  description = "The RDS instance master password"
  value       = random_password.rds_password.result
  sensitive   = true
}

output "dms_replication_instance_arn" {
  description = "The ARN of the DMS replication instance"
  value       = aws_dms_replication_instance.dms.replication_instance_arn
}

output "source_endpoint_arn" {
  description = "The ARN of the source endpoint"
  value       = aws_dms_endpoint.source.endpoint_arn
}

output "target_endpoint_arn" {
  description = "The ARN of the target endpoint"
  value       = aws_dms_endpoint.target.endpoint_arn
}
