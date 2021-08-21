locals {
  descriptor_stack = lookup(module.this.descriptors, "stack", null)

  # If `var.stack` is provided, return it.
  # Else, if `descriptors["stack"]` is specified, use it.
  # Otherwise, construct the stack name from the provided `context`.
  stack_name = var.stack != null ? var.stack : (
    local.descriptor_stack != null ? local.descriptor_stack : (
      module.this.tenant != null ? format("%s-%s-%s", module.this.tenant, module.this.environment, module.this.stage) : (
        # Default stack name from `environment` and `stage`
        format("%s-%s", module.this.environment, module.this.stage)
      )
    )
  )
}
