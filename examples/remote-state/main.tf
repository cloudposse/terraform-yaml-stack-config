module "remote_state_my_vpc" {
  source = "../../modules/remote-state"

  stack_config_local_path = var.stack_config_local_path
  stack                   = var.stack
  component               = "my-vpc"

  context = module.this.context
}

module "remote_state_eks" {
  source = "../../modules/remote-state"

  stack_config_local_path = var.stack_config_local_path
  stack                   = var.stack
  component               = "eks"

  context = module.this.context
}
