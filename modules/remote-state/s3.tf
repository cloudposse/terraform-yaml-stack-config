locals {
  include_component_in_workspace_name = var.include_component_in_workspace_name == true || local.base_component != ""

  s3_workspace_from_stack = local.include_component_in_workspace_name ? format("%s-%s", local.stack, var.component) : local.stack

  s3_workspace = var.workspace != null ? var.workspace : local.s3_workspace_from_stack
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
    role_arn             = var.privileged || ! contains(keys(local.backend), "role_arn") ? null : local.backend.role_arn
    profile              = var.privileged || ! contains(keys(local.backend), "profile") ? null : local.backend.profile
    workspace_key_prefix = var.component
  }

  defaults = var.defaults
}
