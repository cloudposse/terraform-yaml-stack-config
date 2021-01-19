module "stack_config" {
  source                  = "../../"
  stack_config_local_path = var.stack_config_local_path
  stack                   = var.stack
}

module "remote_state_my_vpc" {
  source    = "../../modules/remote-state"
  config    = module.stack_config.config
  component = "my-vpc"
}

module "remote_state_eks" {
  source    = "../../modules/remote-state"
  config    = module.stack_config.config
  component = "eks"
}
