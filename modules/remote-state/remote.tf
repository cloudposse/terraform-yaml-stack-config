locals {
  remote_workspace = var.workspace != null ? var.workspace : local.workspace
}

data "terraform_remote_state" "remote" {
  # workaround for https://github.com/hashicorp/terraform/issues/32023
  count = local.remote_state_enabled && (var.backend_type == "remote" ? true : var.backend_type != "auto" ? false : local.backend_type == "remote") ? 1 : 0


  backend = "remote"

  config = {
    organization = local.backend.organization

    workspaces = {
      name = local.remote_workspace
    }
  }

  defaults = var.defaults
}
