variable "stacks" {
  type        = list(string)
  description = "A list of infrastructure stack names"
}

variable "stack_deps_processing_enabled" {
  type        = bool
  description = "Boolean flag to enable/disable processing all stack dependencies in the provided stack"
  default     = false
}

variable "component_deps_processing_enabled" {
  type        = bool
  description = "Boolean flag to enable/disable processing stack config dependencies for the components in the provided stack"
  default     = true
}

variable "stack_config_path_template" {
  type        = string
  description = "Stack config path template"
  default     = "stacks/%s.yaml"
}
