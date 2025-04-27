resource "aws_security_group" "rds" {
  name_prefix = "${var.environment}-rds-"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.dms.id]
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-rds-sg"
      Environment = var.environment
    }
  )
}

resource "aws_security_group" "dms" {
  name_prefix = "${var.environment}-dms-"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.environment}-dms-sg"
      Environment = var.environment
    }
  )
}
