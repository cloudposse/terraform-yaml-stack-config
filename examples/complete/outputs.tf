output "vars" {
  value       = module.vars.vars
  description = "vars for the component"
}

output "settings" {
  value       = module.settings.settings
  description = "Settings for the component"
}

output "env" {
  value       = module.env.env
  description = "ENV variables for the component"
}

output "stack_name" {
  value       = module.stack.stack_name
  description = "Stack name"
}
