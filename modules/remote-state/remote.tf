data "terraform_remote_state" "remote" {
  count = local.backend_type == "remote" ? 1 : 0

  backend = "remote"

  config = {
    organization = local.backend.organization
    workspaces = {
      name = try(local.backend.workspaces.name, null) != null ? local.backend.workspaces.name : format("%s-%s-%s", local.vars.environment, local.vars.stage, var.component)
    }
  }

  defaults = var.defaults
}
