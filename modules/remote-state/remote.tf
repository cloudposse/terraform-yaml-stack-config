data "terraform_remote_state" "remote" {
  count = local.backend_type == "remote" ? 1 : 0

  backend = "remote"

  config = {
    organization = local.backend.organization

    workspaces = {
      name = var.workspace != null ? var.workspace : (
        try(local.backend.workspace, null) != null ? local.backend.workspace : (
          format("%s-%s-%s", local.vars.environment, local.vars.stage, var.component)
        )
      )
    }
  }

  defaults = var.defaults
}
