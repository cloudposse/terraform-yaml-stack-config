variable "stack_config_local_path" {
  type        = string
  description = "Path to local stack configs"
}

variable "stack" {
  type        = string
  description = "Stack name"
  default     = null
}

variable "component_type" {
  type        = string
  description = "Component type (terraform or helmfile)"
  default     = "terraform"
}

variable "component" {
  type        = string
  description = "Component"
}
