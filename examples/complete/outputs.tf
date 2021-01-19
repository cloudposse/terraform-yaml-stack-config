output "configs" {
  value       = module.stack_config.config
  description = "Stack configs"
}

output "imports" {
  value       = module.stack_config.imports
  description = "List of all imported YAML files"
}

output "vars" {
  value       = module.vars.vars
  description = "Vars configuration for the component"
}

output "backend_type" {
  value       = module.backend.backend_type
  description = "Backend type"
}

output "backend" {
  value       = module.backend.backend
  description = "Backend configuration for the component"
}
