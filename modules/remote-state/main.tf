module "backend_config" {
  source         = "../backend"
  config         = var.config
  component_type = var.component_type
}

locals {
  backend_type = module.backend_config.backend_type
  backend      = module.backend_config.backend

  workspace_from_environment_stage = var.include_component_in_workspace_name ? format("%s-%s-%s", module.this.environment, module.this.stage, var.component) : (
    format("%s-%s", module.this.environment, module.this.stage)
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
