module "backend_config" {
  source         = "../backend"
  config         = var.config
  component_type = var.component_type
}

locals {
  backend_type = module.backend_config.backend_type
  backend      = module.backend_config.backend

  remote_states = {
    s3     = data.terraform_remote_state.s3
    remote = data.terraform_remote_state.remote
  }

  outputs = local.remote_states[local.backend_type][0].outputs
}
