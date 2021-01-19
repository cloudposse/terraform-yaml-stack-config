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
  description = "True if the provider already has access to the backend"
  default     = false
}

variable "defaults" {
  type        = any
  description = "Default values if the data source is empty"
  default     = null
}
