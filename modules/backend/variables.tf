variable "stack" {
  type        = string
  description = "Stack name"
  default     = null
}

variable "component" {
  type        = string
  description = "Component"
}

variable "ignore_errors" {
  type        = bool
  description = "Set to true to ignore errors from the 'utils' provider (if the component is not found in the stack)"
  default     = false
}
