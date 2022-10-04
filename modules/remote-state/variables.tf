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

variable "env" {
  type        = map(string)
  description = "Map of ENV vars in the format `key=value`. These ENV vars will be set in the `utils` provider before executing the data source"
  default     = null
}

variable "atmos_cli_config_path" {
  type        = string
  description = "atmos CLI config path"
  default     = null
}

variable "atmos_base_path" {
  type        = string
  description = "atmos base path to components and stacks"
  default     = null
}
