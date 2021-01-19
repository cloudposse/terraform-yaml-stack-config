data "terraform_remote_state" "s3" {
  count = local.backend_type == "s3" ? 1 : 0

  backend = "s3"

  workspace = var.workspace != null ? var.workspace : (
    format("%s-%s-%s", local.vars.environment, local.vars.stage, var.component)
  )

  config = {
    encrypt              = local.backend.encrypt
    bucket               = local.backend.bucket
    workspace_key_prefix = var.component
    key                  = "terraform.tfstate"
    dynamodb_table       = local.backend.dynamodb_table
    region               = local.vars.region
    role_arn             = var.privileged ? null : local.backend.role_arn
  }

  defaults = var.defaults
}
