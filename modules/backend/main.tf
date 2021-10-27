module "stack" {
  source = "../stack"

  stack   = var.stack
  context = module.always.context
}

data "utils_stack_config_yaml" "config" {
  base_path = var.stack_config_local_path
  input     = [format("%s/%s.yaml", var.stack_config_local_path, module.stack.stack_name)]
}

locals {
  config         = yamldecode(data.utils_stack_config_yaml.config.output[0])
  base_component = try(local.config["components"][var.component_type][var.component]["component"], "")

  final_component = coalesce(local.base_component, var.component)
  backend_type    = try(local.config["components"][var.component_type][local.final_component]["backend_type"], "")
  backend         = try(local.config["components"][var.component_type][local.final_component]["backend"], "")
}
