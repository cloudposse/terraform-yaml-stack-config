output "backend_type" {
  value       = local.backend_type
  description = "Backend type"
}

output "backend" {
  value       = module.yaml_config_backend.merged
  description = "Backend configuration for a component"
}
