# policy/debug.rego
package terraform.debug

# Print resource changes for debugging
warn[msg] {
    resource := input.resource_changes[_]
    msg := sprintf("Resource: %v, Tags: %v", [resource.address, resource.change.after.tags])
}
