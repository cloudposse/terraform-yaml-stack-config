locals {
  remote_workspace_from_environment_stage = format("%s-%s-%s", module.this.environment, module.this.stage, var.component)

  remote_workspace = var.workspace != null ? var.workspace : (
    try(local.backend.workspace, null) != null ? local.backend.workspace : local.remote_workspace_from_environment_stage
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
