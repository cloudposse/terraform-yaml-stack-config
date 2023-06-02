module "remote_state_using_stack" {
  source = "../../modules/remote-state"

  component = "test/test-component-override"
  stack     = "tenant1-ue2-dev"

  # Verify that a default output not matching the real output does not cause a Terraform error
  defaults = {
    val1 = ["default-list"]
    val2 = "default-value"
  }

  env = {
    ATMOS_CLI_CONFIG_PATH = path.module
  }

  atmos_cli_config_path = var.atmos_cli_config_path
  atmos_base_path       = var.atmos_base_path

  context = module.this.context
}

module "remote_state_using_context" {
  source = "../../modules/remote-state"

  component   = "test/test-component-override"
  namespace   = ""
  tenant      = "tenant1"
  environment = "ue2"
  stage       = "dev"

  env = {
    ATMOS_CLI_CONFIG_PATH = path.module
  }

  atmos_cli_config_path = var.atmos_cli_config_path
  atmos_base_path       = var.atmos_base_path

  context = module.this.context
}

module "remote_state_using_context_ignore_errors" {
  source = "../../modules/remote-state"

  # Use a wrong component for testing
  # If `ignore_errors = false`, the `utils` provider will throw the error: Could not find config for the component 'test/test-component-override-wrong' in the stack 'tenant1-ue2-dev'
  # Note that terraform `try()` does not catch errors from providers, so `try(module.remote_state_using_context_ignore_errors.outputs, {})` will not work
  ignore_errors = true
  component     = "test/test-component-override-wrong"
  namespace     = ""
  tenant        = "tenant1"
  environment   = "ue2"
  stage         = "dev"

  defaults = {
    default_output = "default-value"
  }

  env = {
    ATMOS_CLI_CONFIG_PATH = path.module
  }

  atmos_cli_config_path = var.atmos_cli_config_path
  atmos_base_path       = var.atmos_base_path

  context = module.this.context
}

module "remote_state_with_bypass" {
  source = "../../modules/remote-state"

  bypass = true

  defaults = {
    default_output = "default-value"
  }

  component   = "test/test-component-override"
  namespace   = ""
  tenant      = "tenant1"
  environment = "ue2"
  stage       = "dev"

  atmos_cli_config_path = var.atmos_cli_config_path
  atmos_base_path       = var.atmos_base_path

  context = module.this.context
}
