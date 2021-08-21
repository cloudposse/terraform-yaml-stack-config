module "always" {
  source  = "cloudposse/label/null"
  version = "0.25.0"

  # Always enable the `stack` module even if `module.this.context` sets `enabled=false`,
  # because we always need to be able to create stack names even if a top-level calling module is disabled
  # (if we want to set `enabled=false` on the top-level modules and then use `terraform apply` to destroy it)
  enabled = true

  context = module.this.context
}

locals {
  descriptor_stack = lookup(module.always.descriptors, "stack", null)

  # If `var.stack` is provided, return it.
  # Else, if `descriptors["stack"]` is specified, use it.
  # Otherwise, construct the stack name from the provided `context`.
  stack_name = var.stack != null ? var.stack : (
    local.descriptor_stack != null ? local.descriptor_stack : (
      module.always.tenant != null ? format("%s-%s-%s", module.always.tenant, module.always.environment, module.always.stage) : (
        # Default stack name from `environment` and `stage`
        format("%s-%s", module.always.environment, module.always.stage)
      )
    )
  )
}
