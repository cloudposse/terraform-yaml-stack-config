module "yaml_config" {
  source  = "cloudposse/config/yaml"
  version = "0.6.0"

  map_config_local_base_path  = var.stack_config_local_path
  map_config_remote_base_path = var.stack_config_remote_path
  map_config_paths            = [var.stack]
  parameters                  = var.parameters

  context = module.this.context
}
