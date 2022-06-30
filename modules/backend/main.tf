data "utils_component_config" "config" {
  component     = var.component
  stack         = var.stack
  tenant        = module.always.tenant
  environment   = module.always.environment
  stage         = module.always.stage
  ignore_errors = var.ignore_errors
  env           = var.env
}

locals {
  config       = yamldecode(data.utils_component_config.config.output)
  backend_type = local.config.backend_type
  backend      = local.config.backend
}
