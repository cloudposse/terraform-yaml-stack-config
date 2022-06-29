output "backend_type" {
  value       = module.backend.backend_type
  description = "Backend type"
}

output "backend" {
  value       = module.backend.backend
  description = "Backend configuration for the component"
}
