locals {
  include_component_in_workspace_name = var.include_component_in_workspace_name == true || local.base_component != ""

  s3_workspace_from_stack = local.include_component_in_workspace_name ? format("%s-%s", local.stack, var.component) : local.stack

  s3_workspace = var.workspace != null ? var.workspace : local.s3_workspace_from_stack
}

data "terraform_remote_state" "s3" {
  count = local.remote_state_enabled && local.backend_type == "s3" ? 1 : 0

  backend = "s3"

  workspace = local.s3_workspace

  config = {
    encrypt        = local.backend.encrypt
    bucket         = local.backend.bucket
    key            = local.backend.key
    dynamodb_table = local.backend.dynamodb_table
    region         = local.backend.region

    # NOTE: component types
    # Privileged components are those that require elevated (root-level) permissions to provision and access their remote state.
    # For example: `tfstate-backend`, `account`, `account-map`, `account-settings`, `iam-primary`.
    # Privileged components are usually provisioned during cold-start (when we don't have any IAM roles provisioned yet) by using an admin user credentials.
    # To access the remote state of privileged components, the caller needs to have permissions to access the backend and the remote state without assuming roles.
    # Regular components, on the other hand, don't require root-level permissions and are provisioned and their remote state is accessed by assuming IAM roles (or using profiles).
    # For example: `vpc`, `eks`, `rds`

    # NOTE: global `backend` config
    # The global `backend` config should be declared in a global YAML stack config file (e.g. `globals.yaml`)
    # where all stacks can import it and have access to it (note that the global `backend` config is organization-wide and will not change after cold-start).
    # The global `backend` config in the global config file should always have the `role_arn` or `profile` specified (added after the cold-start).

    # NOTE: components `backend` config
    # The `backend` portion for each individual component should be declared in a catalog file (e.g. `stacks/catalog/<component>.yaml`)
    # along with all the default values for a component.
    # The `privileged` attribute should always be declared in the `backend` portion for each individual component in the catalog.
    # Top-level stacks where a component is provisioned import the component's catalog (the default values and the component's backend config portion) and can override the default value.

    # NOTE: `cold-start`
    # During cold-start we don't have any IAM roles provisioned yet, so we use an admin user credentials to provision the privileged components.
    # The `privileged` attribute for the privileged components should be set to `true` in the components'  catalog,
    # and the privileged components should be provisioned using an admin user credentials.

    # NOTE: after `cold-start`
    # After the privileged components (including the primary IAM roles) are provisioned, we update the global `backend` config in the global config file
    # to add the IAM role or profile to access the backend (after this, the global `backend` config should never change).
    # For some privileged components we can change the `privileged` attribute in the YAML config from `true` to `false`
    # to allow the regular components to access their remote state (e.g. we set the `privileged` attribute to `false` in the `account-map` component
    # since we use `account-map` in almost all regular components.
    # For each regular component, set the `privileged` attribute to `false` in the components'  portion of `backend` config (in `stacks/catalog/<component>.yaml`)

    # Advantages:
    # The global `backend` config is specified just once in the global config file, IAM role or profile is added to it after the cold start,
    # and after that the global `backend` config never changed.
    # We can make a component privileged or not any time by just updating its `privileged` attribute in the component's catalog file.
    # We can change a component's `backend` portion any time without touching/affection the backend configs of all other components (e.g. when we add a new
    # component, we don't touch the `globals.yaml` file at all, and we don't update the component's `role_arn` and `profile` settings).

    # Use the role to access the remote state if the component is not privileged and `role_arn` is specified
    role_arn = ! coalesce(try(local.backend.privileged, null), var.privileged) && contains(keys(local.backend), "role_arn") ? local.backend.role_arn : null

    # Use the profile to access the remote state if the component is not privileged and `profile` is specified
    profile = ! coalesce(try(local.backend.privileged, null), var.privileged) && contains(keys(local.backend), "profile") ? local.backend.profile : null

    workspace_key_prefix = coalesce(local.base_component, var.component)
  }

  defaults = var.defaults
}
