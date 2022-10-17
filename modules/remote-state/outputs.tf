output "backend_type" {
  value       = local.backend_type
  description = "Backend type"
}

output "backend" {
  value       = local.backend
  description = "Backend configuration for the component"
}

output "s3_workspace_name" {
  value       = local.ds_backend == "s3" ? local.remote_workspace : null
  description = "(DEPRECATED: use `workspace_name` instead): Terraform workspace name for the component s3 backend"
}

output "remote_workspace_name" {
  value       = local.ds_backend == "remote" ? local.remote_workspace : null
  description = "(DEPRECATED: use `workspace_name` instead): Terraform workspace name for the component remote backend"
}

output "workspace_name" {
  value       = local.remote_workspace
  description = "Terraform workspace name from which to retrieve the Terraform state"
}

output "outputs" {
  value       = local.outputs
  description = "Remote state"
}
