output "map_configs" {
  value       = module.yaml_config.map_configs
  description = "Terraform maps from YAML configurations"
}

output "list_configs" {
  value       = module.yaml_config.list_configs
  description = "Terraform lists from YAML configurations"
}

output "all_imports_list" {
  value       = module.yaml_config.all_imports_list
  description = "List of all imported YAML configurations"
}

output "all_imports_map" {
  value       = module.yaml_config.all_imports_map
  description = "Map of all imported YAML configurations"
}

output "vars" {
  value       = module.yaml_config_vars.map_configs
  description = "vars configuration for the component"
}
