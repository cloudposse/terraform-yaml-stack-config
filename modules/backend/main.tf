data "utils_component_config" "config" {
  component     = var.component
  stack         = var.stack
  ignore_errors = var.ignore_errors
}

locals {
  config       = yamldecode(data.utils_component_config.config.output)
  backend_type = local.config.backend_type
  backend      = local.config.backend
}
