variable "component" {
  type        = string
  description = "Component"
}

variable "stack" {
  type        = string
  description = "Stack name"
}

variable "ignore_errors" {
  type        = bool
  description = "Set to true to ignore errors from the 'utils' provider (if the component is not found in the stack)"
  default     = false
}
