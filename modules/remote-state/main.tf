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
}

data "terraform_remote_state" "s3" {
  count = local.backend_type == "s3" ? 1 : 0

  backend   = "s3"
  workspace = format("%s-%s-%s", local.vars.environment, local.vars.stage, var.component)

  config = {
    encrypt              = local.backend.encrypt
    bucket               = local.backend.bucket
    workspace_key_prefix = var.component
    key                  = "terraform.tfstate"
    dynamodb_table       = local.backend.dynamodb_table
    region               = local.vars.region
    role_arn             = var.privileged ? null : local.backend.role_arn
  }

  defaults = var.defaults
}

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

locals {
  remote_states = {
    s3     = data.terraform_remote_state.s3
    remote = data.terraform_remote_state.remote
  }

  outputs = local.remote_states[local.backend_type][0].outputs
}
