data "utils_stack_config_yaml" "config" {
  input                  = [for stack in var.stacks : format("%s/%s.yaml", var.stack_config_local_path, stack)]
  process_stack_deps     = var.stack_deps_processing_enabled
  process_component_deps = var.component_deps_processing_enabled
}

locals {
  decoded = [for i in data.utils_stack_config_yaml.config.output : yamldecode(i)]

  config = [
    for stack in local.decoded : {
      imports = stack.imports,
      components = {
        helmfile  = stack.components.helmfile,
        terraform = stack.components.terraform
      }
    }
  ]
}
