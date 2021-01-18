output "config" {
  value       = module.yaml_config.map_configs
  description = "Stack configurations"
}

output "imports" {
  value       = module.yaml_config.all_imports_list
  description = "List of all imported YAML files"
}

output "vars" {
  value       = module.yaml_config_vars.map_configs
  description = "Vars configuration for a component"
}

output "backend_type" {
  value       = local.backend_type
  description = "Backend type configuration"
}

output "backend" {
  value       = module.yaml_config_backend.map_configs
  description = "Backend configuration for a component"
}
