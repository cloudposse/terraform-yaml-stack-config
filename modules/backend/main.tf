data "utils_component_config" "config" {
  component = var.component
  stack     = var.stack
}

locals {
  config       = yamldecode(data.utils_stack_config_yaml.config.output)
  backend_type = local.config.backend_type
  backend      = local.config.backend
}
