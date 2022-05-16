variable "stack_config_local_path" {
  type        = string
  description = "Path to local stack configs"
  default     = "examples/complete/stacks"
}

variable "stacks" {
  type        = list(string)
  description = "A list of infrastructure stack names"
  default     = ["my-stack"]
}

variable "stack_deps_processing_enabled" {
  type        = bool
  description = "Boolean flag to enable/disable processing all stack dependencies in the provided stack"
  default     = false
}

variable "component_deps_processing_enabled" {
  type        = bool
  description = "Boolean flag to enable/disable processing stack config dependencies for the components in the provided stack"
  default     = false
}
