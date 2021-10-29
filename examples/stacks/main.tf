module "stacks" {
  source = "../../"

  stack_config_local_path           = "${path.cwd}/stacks"
  stacks                            = var.stacks
  stack_deps_processing_enabled     = var.stack_deps_processing_enabled
  component_deps_processing_enabled = var.component_deps_processing_enabled

  context = module.this.context
}
