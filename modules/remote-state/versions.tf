terraform {
  required_version = ">= 1.1.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 1.3"
    }
    external = {
      source  = "hashicorp/external"
      version = ">= 2.0"
    }
    utils = {
      source = "cloudposse/utils"
      # Do not allow automatic updates to this provider
      # until we have tested the new version thoroughly.
      # Move the <= version constraint to the latest version
      # after testing is complete. Move the >= version constraint
      # when a new version adds a required feature or fixes a bug.
      # If a version in between is found to have a bug,
      # add a != constraint for that version.
      # Leave a redundant != constraint for the last known bad version
      # as an example of how to add a constraint for a bad version.
      version = ">= 1.7.1, != 1.4.0, <= 1.8.0"
    }
  }
}
