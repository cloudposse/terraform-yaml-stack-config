variable "stack_config_local_path" {
  type        = string
  description = "Path to local stack configs"
}

variable "stacks" {
  type        = list(string)
  description = "A list of stack names"
}

variable "process_component_stack_deps" {
  type        = bool
  description = "Boolean flag to enable/disable processing all stack dependencies for the components in the provided stack"
  default     = false
}
