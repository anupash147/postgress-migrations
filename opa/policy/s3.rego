# policy/s3.rego
package terraform.s3

# Ensure S3 buckets have required tags
deny[msg] {
    resource := input.resource_changes[_]
    resource.type == "aws_s3_bucket"
    resource.change.after.tags
    required_tags := {"Environment", "ManagedBy"}
    provided_tags := {key | resource.change.after.tags[key]}
    missing_tags := required_tags - provided_tags
    count(missing_tags) > 0
    msg := sprintf("S3 bucket '%v' is missing required tags: %v", [resource.change.after.bucket, missing_tags])
}

# Ensure versioning is enabled in prod workspace
deny[msg] {
    resource := input.resource_changes[_]
    resource.type == "aws_s3_bucket_versioning"
    terraform.workspace == "prod"
    resource.change.after.versioning_configuration[0].status != "Enabled"
    msg := sprintf("Versioning must be enabled for S3 bucket '%v' in prod workspace", [resource.address])
}

# Ensure bucket names follow convention
deny[msg] {
    resource := input.resource_changes[_]
    resource.type == "aws_s3_bucket"
    not startswith(resource.change.after.bucket, "terraform-workspace-demo-")
    msg := sprintf("S3 bucket name '%v' must start with 'terraform-workspace-demo-'", [resource.change.after.bucket])
}

# Helper rule to get workspace name
terraform.workspace = workspace {
    workspace := input.variables.terraform_workspace.value
}
