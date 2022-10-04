data "utils_component_config" "config" {
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
  config       = yamldecode(data.utils_component_config.config.output)
  backend_type = local.config.backend_type
  backend      = local.config.backend
}
