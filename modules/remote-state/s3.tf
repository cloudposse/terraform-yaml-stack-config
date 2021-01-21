locals {
  s3_workspace_from_environment_stage = var.include_component_in_workspace_name ? format("%s-%s-%s", module.this.environment, module.this.stage, var.component) : (
    format("%s-%s", module.this.environment, module.this.stage)
  )

  s3_workspace = var.workspace != null ? var.workspace : (
    try(local.backend.workspace, null) != null ? local.backend.workspace : local.s3_workspace_from_environment_stage
  )
}

data "terraform_remote_state" "s3" {
  count = local.backend_type == "s3" ? 1 : 0

  backend = "s3"

  workspace = local.s3_workspace

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
