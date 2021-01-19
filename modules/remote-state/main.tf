module "backend" {
  source         = "../backend"
  config         = var.config
  component_type = var.component_type
  component      = var.component
}

module "vars" {
  source         = "../vars"
  config         = var.config
  component_type = var.component_type
  component      = var.component
}

locals {
  backend_type = module.backend.backend_type
  backend      = module.backend.backend
  vars         = module.vars.vars

  environment = coalesce(module.this.environment, local.vars.environment)
  stage       = coalesce(module.this.stage, local.vars.stage)

  workspace_from_environment_stage = var.include_component_in_workspace_name ? format("%s-%s-%s", local.environment, local.stage, var.component) : (
    format("%s-%s", local.environment, local.stage)
  )

  workspace = var.workspace != null ? var.workspace : (
    try(local.backend.workspace, null) != null ? local.backend.workspace : local.workspace_from_environment_stage
  )

  remote_states = {
    s3     = data.terraform_remote_state.s3
    remote = data.terraform_remote_state.remote
  }

  outputs = local.remote_states[local.backend_type][0].outputs
}
