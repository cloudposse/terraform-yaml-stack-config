data "utils_component_config" "config" {
  component = var.component
  stack     = var.stack
}

locals {
  config               = yamldecode(data.utils_component_config.config.output)
  backend_type         = local.config.backend_type
  backend              = local.config.backend
  workspace            = local.config.workspace
  workspace_key_prefix = local.backend.workspace_key_prefix

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
