locals {
  descriptor_stack = lookup(module.always.descriptors, "stack", null)

  # If `var.stack` is provided, return it.
  # Else, if `descriptors["stack"]` is specified, use it.
  # Otherwise, construct the stack name from the provided `context`.
  stack_name = var.stack != null ? var.stack : (
    local.descriptor_stack != null ? local.descriptor_stack : (
      module.always.tenant != null && module.always.tenant != "" ? format("%s-%s-%s", module.always.tenant, module.always.environment, module.always.stage) : (
        # Default stack name from `environment` and `stage`
        format("%s-%s", module.always.environment, module.always.stage)
      )
    )
  )
}
