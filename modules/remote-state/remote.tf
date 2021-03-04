locals {
  remote_workspace = var.workspace != null ? var.workspace : format("%s-%s", local.stack, var.component)
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
