data "terraform_remote_state" "remote" {
  count = local.backend_type == "remote" ? 1 : 0

  backend = "remote"

  config = {
    organization = local.backend.organization

    workspaces = {
      name = local.workspace
    }
  }

  defaults = var.defaults
}
