module "stacks" {
  source = "../../"

  stack_config_local_path                 = var.stack_config_local_path
  stacks                                  = var.stacks
  component_stack_deps_processing_enabled = var.stack_deps_processing_enabled
  component_deps_processing_enabled       = var.component_deps_processing_enabled

  context = module.this.context
}
