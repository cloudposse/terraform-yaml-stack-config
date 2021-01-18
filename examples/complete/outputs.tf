output "configs" {
  value       = module.yaml_stack_config.config
  description = "Stack configurations"
}

output "imports" {
  value       = module.yaml_stack_config.imports
  description = "List of all imported YAML files"
}

output "vars" {
  value       = module.yaml_stack_config.vars
  description = "Vars configuration for a component"
}

output "backend_type" {
  value       = module.yaml_stack_config.backend_type
  description = "Backend type configuration"
}

output "backend" {
  value       = module.yaml_stack_config.backend
  description = "Backend configuration for a component"
}
