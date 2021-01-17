output "map_configs" {
  value       = module.yaml_stack_config.map_configs
  description = "Terraform maps from YAML configurations"
}

output "list_configs" {
  value       = module.yaml_stack_config.list_configs
  description = "Terraform lists from YAML configurations"
}

output "all_imports_list" {
  value       = module.yaml_stack_config.all_imports_list
  description = "List of all imported YAML configurations"
}

output "all_imports_map" {
  value       = module.yaml_stack_config.all_imports_map
  description = "Map of all imported YAML configurations"
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
