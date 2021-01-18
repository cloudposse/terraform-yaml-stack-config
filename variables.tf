variable "stack_config_local_base_path" {
  type        = string
  description = "Base path to local stack configuration files"
  default     = ""
}

variable "stack_config_remote_base_path" {
  type        = string
  description = "Base path to remote stack configuration files"
  default     = ""
}

variable "stack_config_paths" {
  type        = list(string)
  description = "Paths to stack configuration files"
  default     = []
}

variable "parameters" {
  type        = map(string)
  description = "Map of parameters for interpolation within the YAML config templates"
  default     = {}
}

variable "remote_config_selector" {
  type        = string
  description = "String to detect local vs. remote config paths"
  default     = "://"
}

variable "component_type" {
  type        = string
  description = "Component type (terraform or helmfile)"
  default     = "terraform"
}

variable "component" {
  type        = string
  description = "Component"
  default     = null
}
