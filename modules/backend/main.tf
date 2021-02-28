locals {
  enabled = module.this.enabled
  stack   = var.stack != null ? var.stack : format("%s-%s", module.this.environment, module.this.stage)
}

data "utils_stack_config_yaml" "config" {
  count = local.enabled ? 1 : 0
  input = [format("%s/%s.yaml", var.stack_config_local_path, local.stack)]
}

locals {
  config         = try(yamldecode(data.utils_stack_config_yaml.config[0].output[0]), {})
  backend_type   = try(local.config["components"][var.component_type][var.component]["backend_type"], "")
  backend        = try(local.config["components"][var.component_type][var.component]["backend"], {})
  base_component = try(local.config["components"][var.component_type][var.component]["component"], "")
}
