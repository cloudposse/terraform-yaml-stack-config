# remote-state

Terraform module that accepts a component and a stack name and returns remote state outputs for the component.

The module supports all backends supported by Terraform and OpenTofu, plus the Atmos-specific `static` backend.


### Errors

> [!NOTE]
>
>  If you experience an error from the `terraform_remote_state` data source, 
>  this is most likely not an error in this module, but rather an error in the
>  `remote_state` configuration in the referenced stack. This module performs 
>  no validation on the remote state configuration, and only modifies the configuration
>  for the `remote` backend (to set the workspace name) and, 
>  _only when `var.privileged` is set to `true`_, the `s3` configuration (to remove
>  settings for assuming a role). If `var.privileged` is left at the default value of `false`
>  and you are not using the `remote` backend, then this module will not modify the backend
>  configuration in any way.

### "Local" Backend

> [!IMPORTANT]
> 
>  If the local backend has a relative path, it will be resolved
>  relative to the current working directory, which is usually a root module
>  referencing the remote state. However, when the local backend is created,
>  the current working directory is the directory where the target root module
>  is defined. This can cause the lookup to fail if the source is not reachable
>  from the client directory as `../source`.

For example, if your directory structure looks like this:

```text
project
├── components
│   ├── client
│   │   └── main.tf
│   └── complex
│       └── source
│           └── main.tf
└── local-state
    └── complex
        └── source
            └── terraform.tfstate
```

Terraform code in `project/components/complex/source` can create its local state 
file (`terraform.tfstate`) in the `local-state/complex/source`
directory using `path = "../../../local-state/complex/source/terraform.tfstate"`. 
However, Terraform code in `project/components/client` that references the same
local state using the same backend configuration will fail because the current
working directory is `project/components/client` and the relative path will not
resolve correctly.


## Usage

The following example accepts a stack config `my-stack` (which in turn imports other YAML config dependencies)
and returns remote state outputs from the `s3` backend for `my-vpc` and `eks` Terraform components.

__NOTE:__ The backend type (`s3`) and backend configuration for the components are defined in the stack YAML config files.

  ```hcl
    module "remote_state_my_vpc" {
      source = "cloudposse/stack-config/yaml//modules/remote-state"
      # Cloud Posse recommends pinning every module to a specific version
      # version     = "x.x.x"
    
      stack                   = "my-stack"
      component               = "my-vpc"
    }
    
    module "remote_state_eks" {
      source = "cloudposse/stack-config/yaml//modules/remote-state"
      # Cloud Posse recommends pinning every module to a specific version
      # version     = "x.x.x"
    
      stack                   = "my-stack"
      component               = "eks"
    }
  ```

See [examples/remote-state](../../examples/remote-state) for more details.
