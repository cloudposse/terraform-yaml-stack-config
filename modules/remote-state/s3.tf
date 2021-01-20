data "terraform_remote_state" "s3" {
  count = local.backend_type == "s3" ? 1 : 0

  backend = "s3"

  workspace = local.workspace

  config = {
    encrypt              = local.backend.encrypt
    bucket               = local.backend.bucket
    key                  = local.backend.key
    dynamodb_table       = local.backend.dynamodb_table
    region               = local.backend.region
    role_arn             = var.privileged ? null : local.backend.role_arn
    workspace_key_prefix = var.component
  }

  defaults = var.defaults
}
