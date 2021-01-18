output "config" {
  value       = module.yaml_config.map_configs
  description = "Stack config"
}

output "imports" {
  value       = module.yaml_config.all_imports_list
  description = "List of all imported YAML files"
}
