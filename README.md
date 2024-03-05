<!-- markdownlint-disable -->
# terraform-yaml-stack-config <a href="https://cpco.io/homepage?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content="><img align="right" src="https://cloudposse.com/logo-300x69.svg" width="150" /></a>
<a href="https://github.com/cloudposse/terraform-yaml-stack-config/releases/latest"><img src="https://img.shields.io/github/release/cloudposse/terraform-yaml-stack-config.svg" alt="Latest Release"/></a><a href="https://slack.cloudposse.com"><img src="https://slack.cloudposse.com/badge.svg" alt="Slack Community"/></a>
<!-- markdownlint-restore -->

<!--




  ** DO NOT EDIT THIS FILE
  **
  ** This file was automatically generated by the `cloudposse/build-harness`.
  ** 1) Make all changes to `README.yaml`
  ** 2) Run `make init` (you only need to do this once)
  ** 3) Run`make readme` to rebuild this file.
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **





-->

Terraform module that loads and processes an opinionated ["stack" configuration](#examples) from YAML sources
using the [`terraform-provider-utils`](https://github.com/cloudposse/terraform-provider-utils) Terraform provider.

It supports deep-merged variables, settings, ENV variables, backend config, remote state, and [Spacelift](https://spacelift.io/) stacks config outputs for Terraform and helmfile components.


---
> [!NOTE]
> This project is part of Cloud Posse's comprehensive ["SweetOps"](https://cpco.io/homepage?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content=) approach towards DevOps.
> <details><summary><strong>Learn More</strong></summary>
> <a href="https://cpco.io/terraform-modules?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content=terraform_modules">
>   <picture>
>     <source media="(prefers-color-scheme: dark)" srcset="https://docs.cloudposse.com/images/terraform-open-source-modules-light.svg">
>     <source media="(prefers-color-scheme: light)" srcset="https://docs.cloudposse.com/images/terraform-open-source-modules-dark.svg">
>     <img alt="Terraform Open Source Modules" src="https://docs.cloudposse.com/images/terraform-open-source-modules.svg" align="right">
>   </picture>
> </a>
>
>
> It's 100% Open Source and licensed under the [APACHE2](LICENSE).
>
> We literally have [*hundreds of terraform modules*](https://cpco.io/terraform-modules?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content=terraform_modules) that are Open Source and well-maintained. Check them out!
> </details>

<a href="https://cloudposse.com/readme/header/link?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content=readme_header_link"><img src="https://cloudposse.com/readme/header/img"/></a>


## Introduction


The module is composed of the following sub-modules:

  - [vars](modules/vars) - accepts stack configuration and returns deep-merged variables for a Terraform or helmfile component.
  - [settings](modules/settings) - accepts stack configuration and returns deep-merged settings for a Terraform or helmfile component.
  - [env](modules/env) - accepts stack configuration and returns deep-merged ENV variables for a Terraform or helmfile component.
  - [backend](modules/backend) - accepts stack configuration and returns backend config for a Terraform component.
  - [remote-state](modules/remote-state) - accepts stack configuration and returns remote state outputs for a Terraform component.
    The module supports `s3` and `remote` (Terraform Cloud) backends.
  - [spacelift](modules/spacelift) - accepts infrastructure stack configuration and transforms it into Spacelift stacks.



## Usage



> [!IMPORTANT]
> In Cloud Posse's examples, we avoid pinning modules to specific versions to prevent discrepancies between the documentation 
> and the latest released versions. However, for your own projects, we strongly advise pinning each module to the exact version
> you're using. This practice ensures the stability of your infrastructure. Additionally, we recommend implementing a systematic 
> approach for updating versions to avoid unexpected changes.



For a complete example, see [examples/complete](examples/complete).

For automated tests of the complete example using [bats](https://github.com/bats-core/bats-core) and [Terratest](https://github.com/gruntwork-io/terratest),
see [test](test).

For an example on how to configure remote state for Terraform components in YAML config files and then read the components outputs from the remote state,
see [examples/remote-state](examples/remote-state).

For an example on how to process `vars`, `settings`, `env` and `backend` configurations for all Terraform and helmfile components for a list of stacks,
see [examples/stacks](examples/stacks).




## Examples


Here's an example of a stack configuration file:

```yaml
  import:
    - ue2-globals
  vars:
    stage: dev
  terraform:
    vars: {}
  helmfile:
    vars: {}
  components:
    terraform:
      vpc:
        backend:
          s3:
            workspace_key_prefix: "vpc"
        vars:
          cidr_block: "10.102.0.0/18"
      eks:
        backend:
          s3:
            workspace_key_prefix: "eks"
        vars: {}
    helmfile:
      nginx-ingress:
        vars:
          installed: true
```

The `import` section refers to other stack configurations that are automatically deep merged.

### Complete example

This example loads the stack config `my-stack` (which in turn imports other YAML config dependencies)
and returns variables and backend config for the Terraform component `my-vpc` from the stack `my-stack`.

```hcl
  module "vars" {
    source = "cloudposse/stack-config/yaml//modules/vars"
    # version     = "x.x.x"

    stack_config_local_path = "./stacks"
    stack                   = "my-stack"
    component_type          = "terraform"
    component               = "my-vpc"

    context = module.this.context
  }

  module "backend" {
    source = "cloudposse/stack-config/yaml//modules/backend"
    # version     = "x.x.x"

    stack_config_local_path = "./stacks"
    stack                   = "my-stack"
    component_type          = "terraform"
    component               = "my-vpc"

    context = module.this.context
  }

  module "settings" {
    source = "cloudposse/stack-config/yaml//modules/settings"
    # version     = "x.x.x"

    stack_config_local_path = "./stacks"
    stack                   = "my-stack"
    component_type          = "terraform"
    component               = "my-vpc"

    context = module.this.context
  }

  module "env" {
    source = "cloudposse/stack-config/yaml//modules/env"
    # version     = "x.x.x"

    stack_config_local_path = "./stacks"
    stack                   = "my-stack"
    component_type          = "terraform"
    component               = "my-vpc"

    context = module.this.context
  }

```

The example returns the following deep-merged `vars`, `settings`, `env`, and `backend` configurations for the `my-vpc` Terraform component:

```hcl
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

backend_type = "s3"
base_component = "vpc"

env = {
  "ENV_TEST_1" = "test1_override"
  "ENV_TEST_2" = "test2_override"
  "ENV_TEST_3" = "test3"
  "ENV_TEST_4" = "test4"
}

settings = {
  "spacelift" = {
    "autodeploy" = true
    "branch" = "test"
    "triggers" = [
      "1",
      "2",
    ]
    "workspace_enabled" = true
  }
  "version" = 1
}

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

```

See [examples/complete](examples/complete) for more details.


### Remote state example

This example accepts a stack config `my-stack` (which in turn imports other YAML config dependencies)
and returns remote state outputs from the `s3` backend for `my-vpc` and `eks` Terraform components.

__NOTE:__ The backend type (`s3`) and backend configuration for the components are defined in the stack YAML config files.

```hcl
  module "remote_state_my_vpc" {
    source = "cloudposse/stack-config/yaml//modules/remote-state"
    # Cloud Posse recommends pinning every module to a specific version
    # version     = "x.x.x"

    stack_config_local_path = "./stacks"
    stack                   = "my-stack"
    component               = "my-vpc"
  }

  module "remote_state_eks" {
    source = "cloudposse/stack-config/yaml//modules/remote-state"
    # Cloud Posse recommends pinning every module to a specific version
    # version     = "x.x.x"

    stack_config_local_path = "./stacks"
    stack                   = "my-stack"
    component               = "eks"
  }
```

See [examples/remote-state](examples/remote-state) for more details.



<!-- markdownlint-disable -->
## Makefile Targets
```text
Available targets:

  help                                Help screen
  help/all                            Display help for all targets
  help/short                          This help short screen
  lint                                Lint terraform code

```
<!-- markdownlint-restore -->
<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | >= 2.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 1.3 |
| <a name="requirement_utils"></a> [utils](#requirement\_utils) | >= 1.7.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_utils"></a> [utils](#provider\_utils) | >= 1.7.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [utils_stack_config_yaml.config](https://registry.terraform.io/providers/cloudposse/utils/latest/docs/data-sources/stack_config_yaml) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_component_deps_processing_enabled"></a> [component\_deps\_processing\_enabled](#input\_component\_deps\_processing\_enabled) | Boolean flag to enable/disable processing stack config dependencies for the components in the provided stack | `bool` | `false` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stack_config_local_path"></a> [stack\_config\_local\_path](#input\_stack\_config\_local\_path) | Path to local stack configs | `string` | n/a | yes |
| <a name="input_stack_deps_processing_enabled"></a> [stack\_deps\_processing\_enabled](#input\_stack\_deps\_processing\_enabled) | Boolean flag to enable/disable processing all stack dependencies in the provided stack | `bool` | `false` | no |
| <a name="input_stacks"></a> [stacks](#input\_stacks) | A list of infrastructure stack names | `list(string)` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config"></a> [config](#output\_config) | Stack configurations |
<!-- markdownlint-restore -->


## Related Projects

Check out these related projects.

- [terraform-provider-utils](https://github.com/cloudposse/terraform-provider-utils) - The Cloud Posse Terraform Provider for various utilities.
- [terraform-yaml-config](https://github.com/cloudposse/terraform-yaml-config) - Terraform module to convert local and remote YAML configuration templates into Terraform lists and maps.
- [terraform-datadog-monitor](https://github.com/cloudposse/terraform-datadog-monitor) - Terraform module to configure and provision Datadog monitors from a YAML configuration, complete with automated tests.
- [terraform-opsgenie-incident-management](https://github.com/cloudposse/terraform-opsgenie-incident-management) - Terraform module to provision Opsgenie resources from YAML configurations using the Opsgenie provider, complete with automated tests.
- [terraform-aws-components](https://github.com/cloudposse/terraform-aws-components) - Catalog of reusable Terraform components and blueprints for provisioning reference architectures.
- [reference-architectures](https://github.com/cloudposse/reference-architectures) - Get up and running quickly with one of our reference architecture using our fully automated cold-start process.


## References

For additional context, refer to some of these links.

- [Terraform Standard Module Structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure) - HashiCorp's standard module structure is a file and directory layout we recommend for reusable modules distributed in separate repositories.
- [Terraform Module Requirements](https://www.terraform.io/docs/registry/modules/publish.html#requirements) - HashiCorp's guidance on all the requirements for publishing a module. Meeting the requirements for publishing a module is extremely easy.
- [Terraform Version Pinning](https://www.terraform.io/docs/configuration/terraform.html#specifying-a-required-terraform-version) - The required_version setting can be used to constrain which versions of the Terraform CLI can be used with your configuration.
- [Terraform `templatefile` Function](https://www.terraform.io/docs/configuration/functions/templatefile.html) - `templatefile` reads the file at the given path and renders its content as a template using a supplied set of template variables.


## ✨ Contributing

This project is under active development, and we encourage contributions from our community.
Many thanks to our outstanding contributors:

<a href="https://github.com/cloudposse/terraform-yaml-stack-config/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudposse/terraform-yaml-stack-config&max=24" />
</a>

### 🐛 Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/cloudposse/terraform-yaml-stack-config/issues) to report any bugs or file feature requests.

### 💻 Developing

If you are interested in being a contributor and want to get involved in developing this project or help out with Cloud Posse's other projects, we would love to hear from you! 
Hit us up in [Slack](https://cpco.io/slack?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content=slack), in the `#cloudposse` channel.

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.
 1. Review our [Code of Conduct](https://github.com/cloudposse/terraform-yaml-stack-config/?tab=coc-ov-file#code-of-conduct) and [Contributor Guidelines](https://github.com/cloudposse/.github/blob/main/CONTRIBUTING.md).
 2. **Fork** the repo on GitHub
 3. **Clone** the project to your own machine
 4. **Commit** changes to your own branch
 5. **Push** your work back up to your fork
 6. Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!

### 🌎 Slack Community

Join our [Open Source Community](https://cpco.io/slack?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content=slack) on Slack. It's **FREE** for everyone! Our "SweetOps" community is where you get to talk with others who share a similar vision for how to rollout and manage infrastructure. This is the best place to talk shop, ask questions, solicit feedback, and work together as a community to build totally *sweet* infrastructure.

### 📰 Newsletter

Sign up for [our newsletter](https://cpco.io/newsletter?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content=newsletter) and join 3,000+ DevOps engineers, CTOs, and founders who get insider access to the latest DevOps trends, so you can always stay in the know.
Dropped straight into your Inbox every week — and usually a 5-minute read.

### 📆 Office Hours <a href="https://cloudposse.com/office-hours?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content=office_hours"><img src="https://img.cloudposse.com/fit-in/200x200/https://cloudposse.com/wp-content/uploads/2019/08/Powered-by-Zoom.png" align="right" /></a>

[Join us every Wednesday via Zoom](https://cloudposse.com/office-hours?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content=office_hours) for your weekly dose of insider DevOps trends, AWS news and Terraform insights, all sourced from our SweetOps community, plus a _live Q&A_ that you can’t find anywhere else.
It's **FREE** for everyone!

## About

This project is maintained by <a href="https://cpco.io/homepage?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content=">Cloud Posse, LLC</a>.
<a href="https://cpco.io/homepage?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content="><img src="https://cloudposse.com/logo-300x69.svg" align="right" /></a>

We are a [**DevOps Accelerator**](https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content=commercial_support) for funded startups and enterprises.
Use our ready-to-go terraform architecture blueprints for AWS to get up and running quickly.
We build it with you. You own everything. Your team wins. Plus, we stick around until you succeed.

<a href="https://cpco.io/commercial-support?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content=commercial_support"><img alt="Learn More" src="https://img.shields.io/badge/learn%20more-success.svg?style=for-the-badge"/></a>

*Your team can operate like a pro today.*

Ensure that your team succeeds by using our proven process and turnkey blueprints. Plus, we stick around until you succeed.

<details>
  <summary>📚 <strong>See What's Included</strong></summary>

- **Reference Architecture.** You'll get everything you need from the ground up built using 100% infrastructure as code.
- **Deployment Strategy.** You'll have a battle-tested deployment strategy using GitHub Actions that's automated and repeatable.
- **Site Reliability Engineering.** You'll have total visibility into your apps and microservices.
- **Security Baseline.** You'll have built-in governance with accountability and audit logs for all changes.
- **GitOps.** You'll be able to operate your infrastructure via Pull Requests.
- **Training.** You'll receive hands-on training so your team can operate what we build.
- **Questions.** You'll have a direct line of communication between our teams via a Shared Slack channel.
- **Troubleshooting.** You'll get help to triage when things aren't working.
- **Code Reviews.** You'll receive constructive feedback on Pull Requests.
- **Bug Fixes.** We'll rapidly work with you to fix any bugs in our projects.
</details>

<a href="https://cloudposse.com/readme/commercial-support/link?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content=readme_commercial_support_link"><img src="https://cloudposse.com/readme/commercial-support/img"/></a>
## License

<a href="https://opensource.org/licenses/Apache-2.0"><img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg?style=for-the-badge" alt="License"></a>

<details>
<summary>Preamble to the Apache License, Version 2.0</summary>
<br/>
<br/>

Complete license is available in the [`LICENSE`](LICENSE) file.

```text
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
```
</details>

## Trademarks

All other trademarks referenced herein are the property of their respective owners.
## Copyrights

Copyright © 2021-2024 [Cloud Posse, LLC](https://cloudposse.com)



<a href="https://cloudposse.com/readme/footer/link?utm_source=github&utm_medium=readme&utm_campaign=cloudposse/terraform-yaml-stack-config&utm_content=readme_footer_link"><img alt="README footer" src="https://cloudposse.com/readme/footer/img"/></a>

<img alt="Beacon" width="0" src="https://ga-beacon.cloudposse.com/UA-76589703-4/cloudposse/terraform-yaml-stack-config?pixel&cs=github&cm=readme&an=terraform-yaml-stack-config"/>
