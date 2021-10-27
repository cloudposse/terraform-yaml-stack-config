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
  env            = local.config["components"][var.component_type][var.component]["env"]
  base_component = try(local.config["components"][var.component_type][var.component]["component"], "")
}
