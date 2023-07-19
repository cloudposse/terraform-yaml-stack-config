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
      # We were previously pinning this to <=1.8.0, but changing this each time we had a new version was a pain. As
      # a compromise, we'll pin to a minimum version, but allow any patch version below 2.0.0 and we will make sure
      # that if we make any major/breaking changes in cloudposse/utils, we'll increment to 2.0.0.
      version = ">= 1.7.1, != 1.4.0, < 2.0.0"
    }
  }
}
