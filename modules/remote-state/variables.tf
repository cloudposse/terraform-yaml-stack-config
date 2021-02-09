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
  default     = null
}

variable "privileged" {
  type        = bool
  description = "True if the caller already has access to the backend without assuming roles"
  default     = false
}

variable "defaults" {
  type        = any
  description = "Default values if the data source is empty"
  default     = null
}

variable "workspace" {
  type        = string
  description = "Workspace (this overrides the workspace calculated from `var.stack`, `var.environment` and `var.stage`)"
  default     = null
}

variable "include_component_in_workspace_name" {
  type        = bool
  description = "Whether to include the component name in the workspace name. This variable, if set, overrides the `component` attribute in YAML stack configs"
  default     = false
}
