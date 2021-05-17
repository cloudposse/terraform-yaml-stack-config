module "spacelift" {
  source = "../../modules/spacelift"

  stacks                            = var.stacks
  stack_config_path_template        = var.stack_config_path_template
  stack_config_path                 = var.stack_config_path
  stack_deps_processing_enabled     = var.stack_deps_processing_enabled
  component_deps_processing_enabled = var.component_deps_processing_enabled
  imports_processing_enabled        = var.imports_processing_enabled

  context = module.this.context
}
