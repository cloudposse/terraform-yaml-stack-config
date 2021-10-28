module "backend_config" {
  source = "../backend"

  stack_config_local_path = var.stack_config_local_path
  stack                   = var.stack
  component               = var.component
  component_type          = var.component_type

  context = module.always.context
}

module "stack" {
  source = "../stack"

  stack   = var.stack
  context = module.always.context
}

locals {
  stack = module.stack.stack_name

  backend_type   = module.backend_config.backend_type
  backend        = module.backend_config.backend
  base_component = module.backend_config.base_component

  remote_state_enabled = !var.bypass

  remote_states = {
    bypass = [{ outputs = var.defaults }]
    local  = [{ outputs = try(local.backend, {}) }]
    remote = data.terraform_remote_state.remote
    s3     = data.terraform_remote_state.s3
  }

  remote_state_backend_key = var.bypass ? "bypass" : local.backend_type
  outputs                  = try(length(local.remote_state_backend_key), 0) > 0 ? local.remote_states[local.remote_state_backend_key][0].outputs : null
}
