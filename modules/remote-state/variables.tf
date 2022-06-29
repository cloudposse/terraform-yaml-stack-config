variable "stack_config_local_path" {
  type        = string
  description = "Path to local stack configs"
  default     = null
}

variable "stack" {
  type        = string
  description = "Stack name"
  default     = null
}

variable "component" {
  type        = string
  description = "Component"
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
  description = "Workspace (this overrides the workspace calculated from the context)"
  default     = null
}

variable "bypass" {
  type        = bool
  description = "Set to true to skip looking up the remote state and just return the defaults"
  default     = false
}

variable "ignore_errors" {
  type        = bool
  description = "Set to true to ignore errors from the 'utils' provider (if the component is not found in the stack)"
  default     = false
}
