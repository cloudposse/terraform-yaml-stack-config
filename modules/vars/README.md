# vars

Terraform module that accepts stack configuration and returns deep-merged variables for a Terraform or helmfile component.

## Usage

The following example accepts a stack config `my-stack` (which in turn imports other YAML config dependencies)
and returns variables, backend config, and imports for stack `my-stack` and Terraform component `my-vpc`.

  ```hcl
  module "stack_config" {
    source = "cloudposse/stack-config/yaml"
    # Cloud Posse recommends pinning every module to a specific version
    # version     = "x.x.x"

    stack_config_local_path = "./config"
    stack                   = "my-stack"
  }

  module "vars" {
    source = "cloudposse/stack-config/yaml//modules/vars"
    # version     = "x.x.x"

    config         = module.stack_config.config
    component      = "my-vpc"
  }

  module "backend" {
    source = "cloudposse/stack-config/yaml//modules/backend"
    # version     = "x.x.x"

    config         = module.stack_config.config
    component      = "my-vpc"
  }
  ```

The example returns the following `vars`, `backend`, and `import` configurations for `my-stack` stack and `my-vpc` Terraform component:

```hcl
  vars = {
    "availability_zones" = [
      "us-east-2a",
      "us-east-2b",
      "us-east-2c",
    ]
    "cidr_block" = "10.132.0.0/18"
    "environment" = "ue2"
    "level" = 3
    "namespace" = "eg"
    "param" = "param4"
    "region" = "us-east-2"
    "stage" = "prod"
    "subnet_type_tag_key" = "example/subnet/type"
    "test_map" = {
      "a" = "a_override_2"
      "b" = "b_override"
      "c" = [
        1,
        2,
        3,
      ]
      "map2" = {
        "atr1" = 1
        "atr2" = 2
        "atr3" = [
          "3a",
          "3b",
          "3c",
        ]
      }
    }
    "var_1" = "1_override"
    "var_2" = "2_override"
    "var_3" = "3a"
  }

  backend_type = s3

  backend = {
    "acl" = "bucket-owner-full-control"
    "bucket" = "eg-ue2-root-tfstate"
    "dynamodb_table" = "eg-ue2-root-tfstate-lock"
    "encrypt" = true
    "key" = "terraform.tfstate"
    "region" = "us-east-2"
    "role_arn" = "arn:aws:iam::xxxxxxxxxxxx:role/eg-gbl-root-terraform"
    "workspace_key_prefix" = "vpc"
  }

  all_imports_list = [
    "imports-level-2.yaml",
    "imports-level-3.yaml",
    "imports-level-3a.yaml",
    "imports-level-4.yaml",
  ]
```

See [examples/complete](../../examples/complete) for more details.
