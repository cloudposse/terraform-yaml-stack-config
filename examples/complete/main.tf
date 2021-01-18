module "yaml_stack_config" {
  source = "../../"

  stack_config_local_base_path = var.stack_config_local_base_path
  map_config_remote_base_path  = var.stack_config_remote_base_path
  stack_config_paths           = var.stack_config_paths

  parameters             = var.parameters
  remote_config_selector = var.remote_config_selector

  component_type = var.component_type
  component      = var.component

  context = module.this.context
}
