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



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | >= 2.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 1.3 |
| <a name="requirement_utils"></a> [utils](#requirement\_utils) | >= 1.7.1, < 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_utils"></a> [utils](#provider\_utils) | >= 1.7.1, < 2.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_always"></a> [always](#module\_always) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.data_source](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [utils_component_config.config](https://registry.terraform.io/providers/cloudposse/utils/latest/docs/data-sources/component_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br/>This is for some rare cases where resources want additional configuration of tags<br/>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_atmos_base_path"></a> [atmos\_base\_path](#input\_atmos\_base\_path) | atmos base path to components and stacks | `string` | `null` | no |
| <a name="input_atmos_cli_config_path"></a> [atmos\_cli\_config\_path](#input\_atmos\_cli\_config\_path) | atmos CLI config path | `string` | `null` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br/>in the order they appear in the list. New attributes are appended to the<br/>end of the list. The elements of the list are joined by the `delimiter`<br/>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_bypass"></a> [bypass](#input\_bypass) | Set to true to skip looking up the remote state and just return the defaults | `bool` | `false` | no |
| <a name="input_component"></a> [component](#input\_component) | Component | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br/>See description of individual variables for details.<br/>Leave string and numeric variables as `null` to use default value.<br/>Individual variable settings (non-null) override settings in context object,<br/>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br/>  "additional_tag_map": {},<br/>  "attributes": [],<br/>  "delimiter": null,<br/>  "descriptor_formats": {},<br/>  "enabled": true,<br/>  "environment": null,<br/>  "id_length_limit": null,<br/>  "label_key_case": null,<br/>  "label_order": [],<br/>  "label_value_case": null,<br/>  "labels_as_tags": [<br/>    "unset"<br/>  ],<br/>  "name": null,<br/>  "namespace": null,<br/>  "regex_replace_chars": null,<br/>  "stage": null,<br/>  "tags": {},<br/>  "tenant": null<br/>}</pre> | no |
| <a name="input_defaults"></a> [defaults](#input\_defaults) | Default values if the data source is empty | `any` | `null` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br/>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br/>Map of maps. Keys are names of descriptors. Values are maps of the form<br/>`{<br/>   format = string<br/>   labels = list(string)<br/>}`<br/>(Type is `any` so the map values can later be enhanced to provide additional options.)<br/>`format` is a Terraform format string to be passed to the `format()` function.<br/>`labels` is a list of labels, in order, to pass to `format()` function.<br/>Label values will be normalized before being passed to `format()` so they will be<br/>identical to how they appear in `id`.<br/>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_env"></a> [env](#input\_env) | Map of ENV vars in the format `key=value`. These ENV vars will be set in the `utils` provider before executing the data source | `map(string)` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br/>Set to `0` for unlimited length.<br/>Set to `null` for keep the existing setting, which defaults to `0`.<br/>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_ignore_errors"></a> [ignore\_errors](#input\_ignore\_errors) | Set to true to ignore errors from the 'utils' provider (if the component is not found in the stack) | `bool` | `false` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br/>Does not affect keys of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper`.<br/>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br/>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br/>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br/>set as tag values, and output by this module individually.<br/>Does not affect values of tags passed in via the `tags` input.<br/>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br/>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br/>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br/>Default is to include all labels.<br/>Tags with empty values will not be included in the `tags` output.<br/>Set to `[]` to suppress all generated tags.<br/>**Notes:**<br/>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br/>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br/>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br/>  "default"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br/>This is the only ID element not also included as a `tag`.<br/>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_privileged"></a> [privileged](#input\_privileged) | True if the caller already has access to the backend without assuming roles | `bool` | `false` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br/>Characters matching the regex will be removed from the ID elements.<br/>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stack"></a> [stack](#input\_stack) | Stack name | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br/>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_workspace"></a> [workspace](#input\_workspace) | Workspace (this overrides the workspace calculated from the context) | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend"></a> [backend](#output\_backend) | Backend configuration for the component |
| <a name="output_backend_type"></a> [backend\_type](#output\_backend\_type) | Backend type |
| <a name="output_outputs"></a> [outputs](#output\_outputs) | Remote state |
| <a name="output_remote_workspace_name"></a> [remote\_workspace\_name](#output\_remote\_workspace\_name) | (DEPRECATED: use `workspace_name` instead): Terraform workspace name for the component remote backend |
| <a name="output_s3_workspace_name"></a> [s3\_workspace\_name](#output\_s3\_workspace\_name) | (DEPRECATED: use `workspace_name` instead): Terraform workspace name for the component s3 backend |
| <a name="output_workspace_name"></a> [workspace\_name](#output\_workspace\_name) | Terraform workspace name from which to retrieve the Terraform state |
<!-- markdownlint-restore -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

