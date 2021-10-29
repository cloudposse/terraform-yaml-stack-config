locals {
  remote_workspace = var.workspace != null ? var.workspace : local.workspace
}

data "terraform_remote_state" "remote" {
  count = local.remote_state_enabled && local.backend_type == "remote" ? 1 : 0

  backend = "remote"

  config = {
    organization = local.backend.organization

    workspaces = {
      name = local.remote_workspace
    }
  }

  defaults = var.defaults
}
