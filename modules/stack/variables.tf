variable "stack" {
  type        = string
  description = "Stack name. If specified, will be returned as is. If not specified, will be calculated using the provided `context`"
  default     = null
}
