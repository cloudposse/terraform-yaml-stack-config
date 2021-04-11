locals {
  stack = var.stack != null ? var.stack : format("%s-%s", module.this.environment, module.this.stage)
}

data "utils_stack_config_yaml" "config" {
  input = [format("%s/%s.yaml", var.stack_config_local_path, local.stack)]
}

locals {
  config         = yamldecode(data.utils_stack_config_yaml.config.output[0])
  base_component = try(local.config["components"][var.component_type][var.component]["component"], "")

  final_component = coalesce(local.base_component, var.component)
  backend_type    = local.config["components"][var.component_type][local.final_component]["backend_type"]
  backend         = local.config["components"][var.component_type][local.final_component]["backend"]
}
