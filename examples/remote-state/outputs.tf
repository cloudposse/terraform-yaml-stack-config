output "my_vpc_outputs" {
  value       = module.remote_state_my_vpc.outputs
  description = "Remote state outputs of the `my-vpc` component"
}

output "my_vpc_base_component" {
  value       = module.remote_state_my_vpc.base_component
  description = "Base component of `my-vpc` component"
}

output "my_vpc_terraform_workspace" {
  value       = module.remote_state_my_vpc.s3_workspace_name
  description = "Terraform workspace name for the `my-vpc` component s3 backend"
}

output "eks_outputs" {
  value       = module.remote_state_eks.outputs
  description = "Remote state outputs of the `eks` component"
}

output "eks_base_component" {
  value       = module.remote_state_eks.base_component
  description = "Base component of `eks` component"
}

output "eks_terraform_workspace" {
  value       = module.remote_state_eks.s3_workspace_name
  description = "Terraform workspace name for the `eks` component s3 backend"
}
