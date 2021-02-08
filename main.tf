data "utils_stack_config_yaml" "config" {
  input = [for stack in var.stacks : format("%s/%s.yaml", var.stack_config_local_path, stack)]
}

locals {
  config = [for i in data.utils_stack_config_yaml.config.output : yamldecode(i)]
}
