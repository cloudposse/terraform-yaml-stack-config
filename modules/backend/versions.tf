terraform {
  required_version = ">= 0.13.0"

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
      source  = "cloudposse/utils"
      version = ">= 0.8.0"
    }
  }
}
