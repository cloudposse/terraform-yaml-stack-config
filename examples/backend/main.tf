module "backend" {
  source = "../../modules/backend"

  stack         = var.stack
  component     = var.component
  ignore_errors = var.ignore_errors
  env           = var.env

  context = module.this.context
}
