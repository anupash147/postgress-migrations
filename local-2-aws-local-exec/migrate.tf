



# Create a local directory for migration scripts and dumps
resource "local_file" "migration_script" {
  filename = "${path.module}/migration_scripts/perform_migration.sh"
  content  = <<-EOF
    #!/bin/bash
    set -e

    # Source database connection info
    SOURCE_HOST="${var.source_db.host}"
    SOURCE_PORT="${var.source_db.port}"
    SOURCE_DB="${var.source_db.name}"
    SOURCE_USER="${var.source_db.username}"
    export PGPASSWORD="${var.source_db.password}"

    # Target database connection info
    TARGET_HOST="${module.db.db_instance_address}"
    TARGET_PORT="${module.db.db_instance_port}"
    TARGET_DB="${module.db.db_instance_name}"
    TARGET_USER="${module.db.db_instance_username}"
    TARGET_PASSWORD="${var.db_password}"

    echo "Starting database dump..."
    pg_dump -h $SOURCE_HOST \
            -p $SOURCE_PORT \
            -U $SOURCE_USER \
            -d $SOURCE_DB \
            -Fc \
            -v \
            -f "${path.module}/migration_scripts/db_dump.sql"

    echo "Starting database restore..."
    export PGPASSWORD=$TARGET_PASSWORD
    pg_restore -h $TARGET_HOST \
               -p $TARGET_PORT \
               -U $TARGET_USER \
               -d $TARGET_DB \
               -v \
               "${path.module}/migration_scripts/db_dump.sql"

    # Cleanup
    rm -f "${path.module}/migration_scripts/db_dump.sql"
    EOF
}

# Make the migration script executable
resource "null_resource" "make_script_executable" {
  depends_on = [local_file.migration_script]

  provisioner "local-exec" {
    command = "chmod +x ${local_file.migration_script.filename}"
  }
}

# Create migration directory
resource "null_resource" "create_migration_dir" {
  provisioner "local-exec" {
    command = "mkdir -p ${path.module}/migration_scripts"
  }
}

# Perform the database migration
resource "null_resource" "db_migration" {
  depends_on = [
    module.db,
    local_file.migration_script,
    null_resource.make_script_executable
  ]

  # This will trigger the migration when the script changes or when manually triggered
  triggers = {
    script_hash = local_file.migration_script.content_base64sha256
  }

  provisioner "local-exec" {
    command = "${local_file.migration_script.filename}"
    
    environment = {
      PGPASSWORD = var.db_password
    }
  }
}

# Add security group rule to allow local machine access
resource "aws_security_group_rule" "allow_local_postgres" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["${chomp(data.http.my_ip.response_body)}/32"]
  security_group_id = module.security_group.security_group_id
  description       = "Allow PostgreSQL access from local machine"
}


# Outputs
output "migration_script_path" {
  description = "Path to the migration script"
  value       = local_file.migration_script.filename
}

output "source_db_connection" {
  description = "Source database connection string"
  value       = "postgresql://${var.source_db.username}@${var.source_db.host}:${var.source_db.port}/${var.source_db.name}"
  sensitive   = true
}

output "target_db_connection" {
  description = "Target RDS connection string"
  value       = "postgresql://${module.db.db_instance_username}@${module.db.db_instance_endpoint}/${module.db.db_instance_name}"
  sensitive   = true
}
