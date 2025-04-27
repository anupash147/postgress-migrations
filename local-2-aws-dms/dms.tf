resource "aws_dms_replication_subnet_group" "dms" {
  replication_subnet_group_description = "DMS subnet group"
  replication_subnet_group_id         = "${var.environment}-dms-subnet-group"
  subnet_ids                          = module.vpc.private_subnets
}

resource "aws_dms_replication_instance" "dms" {
  allocated_storage            = 50
  apply_immediately           = true
  auto_minor_version_upgrade  = true
  multi_az                    = false
  publicly_accessible         = false
  replication_instance_class  = var.dms_instance_class
  replication_instance_id     = "${var.environment}-dms-instance"
  replication_subnet_group_id = aws_dms_replication_subnet_group.dms.id
  vpc_security_group_ids      = [aws_security_group.dms.id]

  tags = merge(
    var.tags,
    {
      Environment = var.environment
    }
  )
}

resource "aws_dms_endpoint" "source" {
  endpoint_id   = "${var.environment}-source"
  endpoint_type = "source"
  engine_name   = "postgres"
  
  server_name   = var.source_database_host
  port          = var.source_database_port
  database_name = var.source_database_name
  username      = var.source_database_username
  password      = var.source_database_password

  tags = merge(
    var.tags,
    {
      Environment = var.environment
    }
  )
}

resource "aws_dms_endpoint" "target" {
  endpoint_id   = "${var.environment}-target"
  endpoint_type = "target"
  engine_name   = "postgres"

  server_name   = module.rds.db_instance_endpoint
  port          = 5432
  database_name = var.source_database_name
  username      = "dbadmin"
  password      = random_password.rds_password.result

  tags = merge(
    var.tags,
    {
      Environment = var.environment
    }
  )
}

resource "aws_dms_replication_task" "migration" {
  migration_type           = "full-load-and-cdc"
  replication_instance_arn = aws_dms_replication_instance.dms.replication_instance_arn
  replication_task_id      = "${var.environment}-migration-task"
  source_endpoint_arn      = aws_dms_endpoint.source.endpoint_arn
  target_endpoint_arn      = aws_dms_endpoint.target.endpoint_arn
  
  table_mappings = jsonencode({
    rules = [{
      rule-type = "selection"
      rule-id   = "1"
      rule-name = "1"
      object-locator = {
        schema-name = "%"
        table-name  = "%"
      }
      rule-action = "include"
    }]
  })

  tags = merge(
    var.tags,
    {
      Environment = var.environment
    }
  )
}
