module "yaml_config" {
  source  = "cloudposse/config/yaml"
  version = "0.6.0"

  map_config_local_base_path  = var.map_config_local_base_path
  map_config_remote_base_path = var.map_config_remote_base_path
  map_config_paths            = var.map_config_paths

  list_config_local_base_path  = var.list_config_local_base_path
  list_config_remote_base_path = var.list_config_remote_base_path
  list_config_paths            = var.list_config_paths

  parameters             = var.parameters
  remote_config_selector = var.remote_config_selector
  map_configs            = var.map_configs

  context = module.this.context
}

locals {
  conf = module.yaml_config.map_configs

  component = try(local.conf["components"][var.component_type][var.component]["component"], null)

  # Deep-merge all variables in this order: global-scoped, component-type-scoped, component-scoped, component-instance-scoped
  vars = [
    try(local.conf["vars"], {}),
    try(local.conf[var.component_type]["vars"], {}),
    try(local.conf["components"][var.component_type][local.component]["vars"], {}),
    try(local.conf["components"][var.component_type][var.component]["vars"], {})
  ]
}

module "yaml_config_vars" {
  source  = "cloudposse/config/yaml"
  version = "0.6.0"

  map_configs = local.vars

  context = module.this.context
}
