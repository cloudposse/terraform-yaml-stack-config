output "backend_type" {
  value       = local.backend_type
  description = "Backend type"
}

output "backend" {
  value       = local.backend
  description = "Backend configuration for the component"
}

output "outputs" {
  value       = local.outputs
  description = "The outputs of the component"
}
