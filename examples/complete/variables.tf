variable "stack_config_local_path" {
  type        = string
  description = "Path to local stack configs"
}

variable "stack" {
  type        = string
  description = "Stack name"
}

variable "parameters" {
  type        = map(string)
  description = "Map of parameters for interpolation within the YAML config templates"
  default     = {}
}

variable "component_type" {
  type        = string
  description = "Component type"
}

variable "component" {
  type        = string
  description = "Component"
}
