data "utils_component_config" "config" {
  count = var.bypass ? 0 : 1

  component             = var.component
  stack                 = var.stack
  namespace             = module.always.namespace
  tenant                = module.always.tenant
  environment           = module.always.environment
  stage                 = module.always.stage
  ignore_errors         = var.ignore_errors
  env                   = var.env
  atmos_cli_config_path = var.atmos_cli_config_path
  atmos_base_path       = var.atmos_base_path
}

locals {
  config = try(yamldecode(data.utils_component_config.config[0].output), {})

  remote_state_backend_type = try(local.config.remote_state_backend_type, "")
  backend_type              = try(coalesce(local.remote_state_backend_type, local.config.backend_type), "")

  # If `config.remote_state_backend` is not declared in YAML config, the default value will be an empty map `{}`
  backend_config_key = try(local.config.remote_state_backend, null) != null && try(length(local.config.remote_state_backend), 0) > 0 ? "remote_state_backend" : "backend"

  # This is used because the `?` operator in some instances (depending on the condition) changes the types of all items of the map to all `strings`
  backend_configs = {
    backend              = lookup(local.config, "backend", {})
    remote_state_backend = lookup(local.config, "remote_state_backend", {})
  }

  backend = local.backend_configs[local.backend_config_key]

  workspace            = lookup(local.config, "workspace", "")
  workspace_key_prefix = lookup(local.backend, "workspace_key_prefix", null)

  remote_states = {
    # s3     = data.terraform_remote_state.s3
    # remote = data.terraform_remote_state.remote
    data_source = try(data.terraform_remote_state.data_source[0].outputs, var.defaults)
    bypass      = var.defaults
    static      = local.backend
  }

  remote_state_backend_key          = var.bypass ? "bypass" : local.is_data_source_backend ? "data_source" : local.backend_type
  computed_remote_state_backend_key = try(length(local.remote_states[local.remote_state_backend_key]), 0) > 0 ? local.remote_state_backend_key : "bypass"

  outputs = local.remote_states[local.computed_remote_state_backend_key]
}
