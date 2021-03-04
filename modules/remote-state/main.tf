module "backend_config" {
  source = "../backend"

  # Always enable the `backend` module even if `module.this.context` sets `enabled=false`,
  # because we always need to read the remote state (it needs `environment` and `stage` from the context)
  # even if a top-level calling module is disabled
  # (if we want to set `enabled=false` on the top-level modules and then use `terraform apply` to destroy it)
  enabled = true

  stack_config_local_path = var.stack_config_local_path
  stack                   = var.stack
  component               = var.component
  component_type          = var.component_type

  context = module.this.context
}

locals {
  stack = var.stack != null ? var.stack : format("%s-%s", module.this.environment, module.this.stage)

  backend_type   = module.backend_config.backend_type
  backend        = module.backend_config.backend
  base_component = module.backend_config.base_component

  remote_states = {
    s3     = data.terraform_remote_state.s3
    remote = data.terraform_remote_state.remote
  }

  outputs = local.remote_states[local.backend_type][0].outputs
}
