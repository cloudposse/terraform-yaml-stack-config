data "utils_component_config" "config" {
  component = var.component
  stack     = var.stack
}

locals {
  config       = yamldecode(data.utils_component_config.config.output)
  backend_type = local.config.backend_type
  backend      = local.config.backend
}
