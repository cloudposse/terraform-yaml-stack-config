locals {
  component = try(var.config["components"][var.component_type][var.component]["component"], null)

  backend_type = coalesce(
    try(var.config["backend_type"], null),
    try(var.config[var.component_type]["backend_type"], null),
    try(var.config["components"][var.component_type][var.component]["backend_type"], null),
    "s3"
  )

  # Deep-merge all backend attributes in this order: global-scoped, component-type-scoped, component-scoped, component-instance-scoped
  backend = [
    try(var.config["backend"][local.backend_type], {}),
    try(var.config[var.component_type]["backend"][local.backend_type], {}),
    try(var.config["components"][var.component_type][local.component]["backend"][local.backend_type], {}),
    try(var.config["components"][var.component_type][var.component]["backend"][local.backend_type], {})
  ]
}

module "yaml_config_backend" {
  source = "../deepmerge"
  maps   = local.backend
}
