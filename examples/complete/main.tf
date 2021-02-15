module "vars" {
  source = "../../modules/vars"

  stack_config_local_path = var.stack_config_local_path
  stack                   = var.stack
  component_type          = var.component_type
  component               = var.component

  context = module.this.context
}

module "backend" {
  source = "../../modules/backend"

  stack_config_local_path = var.stack_config_local_path
  stack                   = var.stack
  component_type          = var.component_type
  component               = var.component

  context = module.this.context
}

module "settings" {
  source = "../../modules/settings"

  stack_config_local_path = var.stack_config_local_path
  stack                   = var.stack
  component_type          = var.component_type
  component               = var.component

  context = module.this.context
}

module "env" {
  source = "../../modules/env"

  stack_config_local_path = var.stack_config_local_path
  stack                   = var.stack
  component_type          = var.component_type
  component               = var.component

  context = module.this.context
}

