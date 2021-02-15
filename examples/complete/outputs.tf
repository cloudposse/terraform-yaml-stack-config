output "vars" {
  value       = module.vars.vars
  description = "vars for the component"
}

output "backend_type" {
  value       = module.backend.backend_type
  description = "Backend type"
}

output "backend" {
  value       = module.backend.backend
  description = "Backend configuration for the component"
}

output "base_component" {
  value       = module.backend.base_component
  description = "Base component name"
}

output "settings" {
  value       = module.settings.settings
  description = "settings for the component"
}

output "env" {
  value       = module.env.env
  description = "ENV variables for the component"
}
