module "always" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  # Always enable the `backend` module even if `module.this.context` sets `enabled=false`,
  # because we always need to read the remote state (it needs `environment` and `stage` from the context)
  # even if a top-level calling module is disabled
  # (if we want to set `enabled=false` on the top-level modules and then use `terraform apply` to destroy it)
  enabled = true

  context = module.this.context
}

module "backend_config" {
  source = "../backend"

  stack_config_local_path = var.stack_config_local_path
  stack                   = var.stack
  component               = var.component
  component_type          = var.component_type

  context = module.always.context
}

locals {
  stack = var.stack != null ? var.stack : format("%s-%s", module.always.environment, module.always.stage)

  backend_type   = module.backend_config.backend_type
  backend        = module.backend_config.backend
  base_component = module.backend_config.base_component

  remote_state_enabled = ! var.bypass

  remote_states = {
    s3     = data.terraform_remote_state.s3
    remote = data.terraform_remote_state.remote
    bypass = [{ outputs = var.defaults }]
  }

  remote_state_backend_key = var.bypass ? "bypass" : local.backend_type
  outputs                  = try(length(local.remote_state_backend_key), 0) > 0 ? local.remote_states[local.remote_state_backend_key][0].outputs : null
}
