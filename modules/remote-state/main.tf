module "backend_config" {
  source = "../backend"

  stack_config_local_path = var.stack_config_local_path
  stack                   = var.stack
  component               = var.component
  component_type          = var.component_type

  context = module.this.context
}

locals {
  backend_type   = module.backend_config.backend_type
  backend        = module.backend_config.backend
  base_component = module.backend_config.base_component

  remote_states = {
    s3     = data.terraform_remote_state.s3
    remote = data.terraform_remote_state.remote
  }

  outputs = local.remote_states[local.backend_type][0].outputs
}
