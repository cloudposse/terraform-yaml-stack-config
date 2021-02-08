variable "stack_config_local_path" {
  type        = string
  description = "Path to local stack configs"
}

variable "stacks" {
  type        = list(string)
  description = "A list of stack names"
}
