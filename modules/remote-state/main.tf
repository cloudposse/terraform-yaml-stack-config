module "backend" {
  source         = "../backend"
  config         = var.config
  component_type = var.component_type
  component      = var.component
}

module "vars" {
  source         = "../vars"
  config         = var.config
  component_type = var.component_type
  component      = var.component
}

locals {
  backend_type = module.backend.backend_type
  backend      = module.backend.backend
  vars         = module.vars.vars

  remote_states = {
    s3     = data.terraform_remote_state.s3
    remote = data.terraform_remote_state.remote
  }

  outputs = local.remote_states[local.backend_type][0].outputs
}
