output "my_vpc_outputs" {
  value       = module.remote_state_my_vpc.outputs
  description = "Remote state outputs of the `my-vpc` component"
}

output "eks_outputs" {
  value       = module.remote_state_eks.outputs
  description = "Remote state outputs of the `eks` component"
}
