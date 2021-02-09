locals {
  stack = var.stack != null ? var.stack : format("%s-%s", module.this.environment, module.this.stage)
}

data "utils_stack_config_yaml" "config" {
  input = [format("%s/%s.yaml", var.stack_config_local_path, local.stack)]
}

locals {
  backend_type   = yamldecode(data.utils_stack_config_yaml.config.output[0])["components"][var.component_type][var.component]["backend_type"]
  backend        = yamldecode(data.utils_stack_config_yaml.config.output[0])["components"][var.component_type][var.component]["backend"]
  base_component = try(yamldecode(data.utils_stack_config_yaml.config.output[0])["components"][var.component_type][var.component]["component"], "")
}
