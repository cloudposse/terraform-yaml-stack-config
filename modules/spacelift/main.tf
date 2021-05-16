data "utils_spacelift_stack_config" "example" {
  input                      = [for stack in var.stacks : format(var.stack_config_path_template, stack)]
  process_stack_deps         = var.stack_deps_processing_enabled
  process_component_deps     = var.component_deps_processing_enabled
  stack_config_path_template = var.stack_config_path_template
}

locals {
  spacelift_stacks = yamldecode(data.utils_stack_config_yaml.config.output)
}
