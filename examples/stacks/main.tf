module "stacks" {
  source = "../../"

  stack_config_local_path = var.stack_config_local_path
  stacks                  = var.stacks

  context = module.this.context
}
