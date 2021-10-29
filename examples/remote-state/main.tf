module "remote_state" {
  source = "../../modules/remote-state"

  component = "test/test-component-override"
  stack     = "tenant1-ue2-dev"

  context = module.this.context
}
