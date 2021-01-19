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
  default     = null
}
