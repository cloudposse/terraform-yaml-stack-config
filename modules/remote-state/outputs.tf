output "backend_type" {
  value       = local.backend_type
  description = "Backend type"
}

output "backend" {
  value       = local.backend
  description = "Backend configuration for the component"
}

output "base_component" {
  value       = local.base_component
  description = "Base component name"
}

output "outputs" {
  value       = local.outputs
  description = "The outputs of the component"
}
