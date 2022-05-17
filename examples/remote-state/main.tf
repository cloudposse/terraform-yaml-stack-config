module "remote_state_using_stack" {
  source = "../../modules/remote-state"

  component = "test/test-component-override"
  stack     = "tenant1-ue2-dev"

  context = module.this.context
}

module "remote_state_using_context" {
  source = "../../modules/remote-state"

  component   = "test/test-component-override"
  tenant      = "tenant1"
  environment = "ue2"
  stage       = "dev"

  context = module.this.context
}

module "remote_state_using_context_ignore_errors" {
  source = "../../modules/remote-state"

  # Use a wrong component for testing
  # If `ignore_errors = false`, the `utils` provider will throw the error: Could not find config for the component 'test/test-component-override-wrong' in the stack 'tenant1-ue2-dev'
  # Note that terraform `try()` does not catch errors from providers, so `try(module.remote_state_using_context_ignore_errors.outputs, {})` will not work
  ignore_errors = true
  component     = "test/test-component-override-wrong"
  tenant        = "tenant1"
  environment   = "ue2"
  stage         = "dev"

  defaults = {
    default_output = "default-value"
  }

  context = module.this.context
}
