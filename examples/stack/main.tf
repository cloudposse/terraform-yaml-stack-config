# Since `var.stack` is provided, the module should just return it
module "stack_1" {
  source = "../../modules/stack"

  stack = var.stack

  context = module.this.context
}

# Since `var.stack` is provided, the module should just return it regardless of all other settings
module "stack_2" {
  source = "../../modules/stack"

  stack       = var.stack
  environment = "uw2"
  stage       = "dev"

  context = module.this.context
}

# Since `var.stack` and `var.descriptor_formats` are not provided, the module creates the stack name from the provided context
module "stack_3" {
  source = "../../modules/stack"

  environment = "uw2"
  stage       = "dev"

  context = module.this.context
}

# Since `var.stack` and `var.descriptor_formats` are not provided, the module creates the stack name from the provided context
module "stack_4" {
  source = "../../modules/stack"

  tenant      = "acme"
  environment = "uw2"
  stage       = "dev"

  context = module.this.context
}

# Test `descriptor_formats`
module "stack_5" {
  source = "../../modules/stack"

  tenant      = "acme"
  environment = "uw2"
  stage       = "dev"

  descriptor_formats = {
    stack = {
      labels = ["tenant", "environment", "stage"]
      format = "%v-%v-%v"
    }
  }

  context = module.this.context
}

# Test `descriptor_formats`
module "stack_6" {
  source = "../../modules/stack"

  tenant      = "acme"
  environment = "uw2"
  stage       = "dev"

  descriptor_formats = {
    stack = {
      labels = ["stage", "environment", "tenant"]
      format = "%v-%v-%v"
    }
  }

  context = module.this.context
}

# Test `descriptor_formats`
module "stack_7" {
  source = "../../modules/stack"

  tenant      = "acme"
  environment = "uw2"
  stage       = "dev"

  descriptor_formats = {
    stack = {
      labels = ["environment", "tenant", "stage"]
      format = "%v-%v-%v"
    }
  }

  context = module.this.context
}

# Test `descriptor_formats`
module "stack_8" {
  source = "../../modules/stack"

  tenant      = "acme"
  environment = "uw2"
  stage       = "dev"

  descriptor_formats = {
    stack = {
      labels = ["stage", "tenant", "environment"]
      format = "%v-%v-%v"
    }
  }

  context = module.this.context
}

# Since `var.stack` is provided, the module should just return it regardless of all other settings (don't use `var.stack` and `var.descriptor_formats)
module "stack_9" {
  source = "../../modules/stack"

  stack       = var.stack
  tenant      = "acme"
  environment = "uw2"
  stage       = "dev"

  descriptor_formats = {
    stack = {
      labels = ["tenant", "environment", "stage"]
      format = "%v-%v-%v"
    }
  }

  context = module.this.context
}
