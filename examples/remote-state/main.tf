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
