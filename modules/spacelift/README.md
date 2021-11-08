# spacelift

Terraform module that accepts infrastructure stack configurations and transforms it into Spacelift stacks.

## Usage

The following example loads the infrastructure YAML stack configs and returns Spacelift stack configurations:


  ```hcl
    module "spacelift" {
      source = "../../modules/spacelift"
  
      stack_config_path_template        = "stacks/%s.yaml"
      component_deps_processing_enabled = true
    
      context = module.this.context
    }
  ```

See [examples/spacelift](../../examples/spacelift) for more details.
