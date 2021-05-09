module "stacks" {
  source = "../../"

  stack_config_local_path      = var.stack_config_local_path
  stacks                       = var.stacks
  process_component_stack_deps = var.process_component_stack_deps
  process_component_deps       = var.process_component_deps

  context = module.this.context
}
