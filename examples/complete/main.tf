module "stack_config" {
  source = "../../"

  stack_config_local_path = var.stack_config_local_path
  stack                   = var.stack
  parameters              = var.parameters

  context = module.this.context
}

module "vars" {
  source = "../../modules/vars"

  config         = module.stack_config.config
  component_type = var.component_type
  component      = var.component
}

module "backend" {
  source = "../../modules/backend"

  config         = module.stack_config.config
  component_type = var.component_type
  component      = var.component
}
