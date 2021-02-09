locals {
  stack = var.stack != null ? var.stack : format("%s-%s", module.this.environment, module.this.stage)

  remote_workspace_from_stack = format("%s-%s", local.stack, var.component)

  remote_workspace = var.workspace != null ? var.workspace : (
    try(local.backend.workspace, null) != null ? local.backend.workspace : local.remote_workspace_from_stack
  )
}

data "terraform_remote_state" "remote" {
  count = local.backend_type == "remote" ? 1 : 0

  backend = "remote"

  config = {
    organization = local.backend.organization

    workspaces = {
      name = local.remote_workspace
    }
  }

  defaults = var.defaults
}
