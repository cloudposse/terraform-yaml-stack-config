module "yaml_config" {
  source  = "cloudposse/config/yaml"
  version = "0.6.0"

  map_config_local_base_path  = var.stack_config_local_base_path
  map_config_remote_base_path = var.stack_config_remote_base_path
  map_config_paths            = var.stack_config_paths

  parameters             = var.parameters
  remote_config_selector = var.remote_config_selector

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

  backend_type = coalesce(
    try(local.conf["backend_type"], null),
    try(local.conf[var.component_type]["backend_type"], null),
    try(local.conf["components"][var.component_type][var.component]["backend_type"], null),
    "s3"
  )

  # Deep-merge all backend attributes in this order: global-scoped, component-type-scoped, component-scoped, component-instance-scoped
  backend = [
    try(local.conf["backend"][local.backend_type], {}),
    try(local.conf[var.component_type]["backend"][local.backend_type], {}),
    try(local.conf["components"][var.component_type][local.component]["backend"][local.backend_type], {}),
    try(local.conf["components"][var.component_type][var.component]["backend"][local.backend_type], {})
  ]
}

module "deepmerge_vars" {
  source = "./modules/deepmerge"
  maps   = local.vars
}

module "yaml_config_backend" {
  source = "./modules/deepmerge"
  maps   = local.backend
}
