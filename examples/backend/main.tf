module "backend" {
  source = "../../modules/backend"

  stack         = var.stack
  component     = var.component
  ignore_errors = var.ignore_errors

  context = module.this.context
}
