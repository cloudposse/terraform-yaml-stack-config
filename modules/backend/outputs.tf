output "backend_type" {
  value       = local.backend_type
  description = "Backend type"
}

output "backend" {
  value       = module.backend.merged
  description = "Backend configuration for the component"
}
