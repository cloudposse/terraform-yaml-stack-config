output "config" {
  value       = module.yaml_config.map_configs
  description = "Stack configurations"
}

output "imports" {
  value       = module.yaml_config.all_imports_list
  description = "List of all imported YAML files"
}

output "vars" {
  value       = module.deepmerge_vars.merged
  description = "Vars configuration for a component"
}

output "backend_type" {
  value       = local.backend_type
  description = "Backend type configuration"
}

output "backend" {
  value       = module.yaml_config_backend.merged
  description = "Backend configuration for a component"
}
