module "backend" {
  source = "../../modules/backend"

  stack                 = var.stack
  component             = var.component
  ignore_errors         = var.ignore_errors
  env                   = var.env
  atmos_cli_config_path = var.atmos_cli_config_path
  atmos_base_path       = var.atmos_base_path

  context = module.this.context
}
