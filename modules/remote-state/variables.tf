variable "config" {
  type        = any
  description = "Stack configuration"
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
  description = "Workspace"
  default     = null
}

variable "include_component_in_workspace_name" {
  type        = bool
  description = "Whether to include the component name in the workspace name"
  default     = false
}
