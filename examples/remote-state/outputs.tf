output "remote_state_using_stack" {
  value       = module.remote_state_using_stack.outputs
  description = "Component remote state using the provided stack name"
}

output "remote_state_using_context" {
  value       = module.remote_state_using_context.outputs
  description = "Component remote state using the provided context"
}

output "remote_state_using_context_ignore_errors" {
  value       = module.remote_state_using_context_ignore_errors.outputs
  description = "Component remote state using wrong component. Errors are ignored in the 'utils' provider"
}
