data "utils_spacelift_stack_config" "spacelift_stacks" {
  process_stack_deps         = var.stack_deps_processing_enabled
  process_component_deps     = var.component_deps_processing_enabled
  process_imports            = var.imports_processing_enabled
  stack_config_path_template = var.stack_config_path_template
  env                        = var.env
}

locals {
  spacelift_stacks = yamldecode(data.utils_spacelift_stack_config.spacelift_stacks.output)
}
