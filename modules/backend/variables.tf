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

variable "env" {
  type        = map(string)
  description = "Map of ENV vars in the format `key=value`. These ENV vars will be set in the `utils` provider before executing the data source"
  default     = null
}
