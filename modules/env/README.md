# env

Terraform module that accepts stack configuration and returns deep-merged ENV variables for a Terraform or helmfile component.

## Usage

The following example loads the stack config `my-stack` (which in turn imports other YAML config dependencies)
and returns ENV variables for Terraform component `my-vpc`.

  ```hcl
    module "vars" {
      source = "cloudposse/stack-config/yaml//modules/env"
      # version     = "x.x.x"
    
      stack_config_local_path = "./stacks"
      stack                   = "my-stack"
      component_type          = "terraform"
      component               = "my-vpc"
    
      context = module.this.context
    }
```

See [examples/complete](../../examples/complete) for more details.
