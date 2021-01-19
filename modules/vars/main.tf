locals {
  component = try(var.config["components"][var.component_type][var.component]["component"], null)

  # Deep-merge all variables in this order: global-scoped, component-type-scoped, component-scoped, component-instance-scoped
  vars = [
    try(var.config["vars"], {}),
    try(var.config[var.component_type]["vars"], {}),
    try(var.config["components"][var.component_type][local.component]["vars"], {}),
    try(var.config["components"][var.component_type][var.component]["vars"], {})
  ]
}

module "vars" {
  source = "../deepmerge"
  maps   = local.vars
}
