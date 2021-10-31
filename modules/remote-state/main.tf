data "utils_component_config" "config" {
  component   = var.component
  stack       = var.stack
  tenant      = module.always.tenant
  environment = module.always.environment
  stage       = module.always.stage
}

locals {
  config = yamldecode(data.utils_component_config.config.output)

  remote_state_backend_type = try(local.config.remote_state_backend_type, "")
  backend_type              = coalesce(local.remote_state_backend_type, local.config.backend_type)

  remote_state_backend = try(local.config.remote_state_backend, null) != null ? local.config.remote_state_backend : null
  backend              = local.remote_state_backend != null ? local.remote_state_backend : local.config.backend

  workspace            = local.config.workspace
  workspace_key_prefix = lookup(local.backend, "workspace_key_prefix", null)

  remote_state_enabled = !var.bypass

  remote_states = {
    s3     = data.terraform_remote_state.s3
    remote = data.terraform_remote_state.remote
    bypass = [{ outputs = var.defaults }]
    static = [{ outputs = local.backend }]
  }

  remote_state_backend_key = var.bypass ? "bypass" : local.backend_type
  outputs                  = try(length(local.remote_state_backend_key), 0) > 0 ? local.remote_states[local.remote_state_backend_key][0].outputs : null
}
