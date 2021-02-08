# stacks

Terraform module to process stack configurations for Terraform and helmfile components.


## Usage

  ```hcl
    module "stacks" {
      source = "cloudposse/stack-config/yaml"
      # version     = "x.x.x"
    
      stack_config_local_path = "./stacks"

      stacks = [
        "uw2-dev",
        "uw2-prod",
        "uw2-staging",
        "uw2-uat"
      ]
    }
  ```

The module returns `vars` and `backend` configurations for all Terraform and helmfile components for all the provided stacks in the following format:

  ```hcl
  config = [
      {
        "components" = {
          "helmfile" = {
            "alb-controller" = {
              "vars" = {
                "account_number" = "1234567890"
                "chart_values" = {
                  "enableCertManager" = true
                }
                "environment" = "uw2"
                "installed" = true
                "namespace" = "eg"
                "region" = "us-west-2"
                "ssm_region" = "us-west-2"
                "stage" = "dev"
              }
            }
            "cert-manager" = {
              "vars" = {
                "account_number" = "1234567890"
                "environment" = "uw2"
                "installed" = true
                "namespace" = "eg"
                "region" = "us-west-2"
                "ssm_region" = "us-west-2"
                "stage" = "dev"
              }
            }
          }
          "terraform" = {
            "account" = {
              "backend" = {
                "acl" = "bucket-owner-full-control"
                "bucket" = "eg-uw2-root-tfstate"
                "dynamodb_table" = "eg-uw2-root-tfstate-lock"
                "encrypt" = true
                "key" = "terraform.tfstate"
                "region" = "us-west-2"
                "role_arn" = null
                "workspace_key_prefix" = "account"
              }
              "backend_type" = "s3"
              "vars" = {
                "environment" = "uw2"
                "namespace" = "eg"
                "region" = "us-west-2"
                "stage" = "dev"
              }
            }
            "aurora-postgres" = {
              "backend" = {
                "acl" = "bucket-owner-full-control"
                "bucket" = "eg-uw2-root-tfstate"
                "dynamodb_table" = "eg-uw2-root-tfstate-lock"
                "encrypt" = true
                "key" = "terraform.tfstate"
                "region" = "us-west-2"
                "role_arn" = "arn:aws:iam::XXXXXXXXXXXX:role/eg-gbl-root-terraform"
                "workspace_key_prefix" = "aurora-postgres"
              }
              "backend_type" = "s3"
              "vars" = {
                "cluster_size" = 1
                "environment" = "uw2"
                "instance_type" = "db.r4.large"
                "namespace" = "eg"
                "region" = "us-west-2"
                "stage" = "dev"
              }
            }
            "aurora-postgres-2" = {
              "backend" = {
                "acl" = "bucket-owner-full-control"
                "bucket" = "eg-uw2-root-tfstate"
                "dynamodb_table" = "eg-uw2-root-tfstate-lock"
                "encrypt" = true
                "key" = "terraform.tfstate"
                "region" = "us-west-2"
                "role_arn" = "arn:aws:iam::XXXXXXXXXXXX:role/eg-gbl-root-terraform"
                "workspace_key_prefix" = "aurora-postgres"
              }
              "backend_type" = "s3"
              "vars" = {
                "cluster_size" = 1
                "environment" = "uw2"
                "instance_type" = "db.r4.xlarge"
                "namespace" = "eg"
                "region" = "us-west-2"
                "stage" = "dev"
              }
            }
            "efs" = {
              "backend" = {
                "acl" = "bucket-owner-full-control"
                "bucket" = "eg-uw2-root-tfstate"
                "dynamodb_table" = "eg-uw2-root-tfstate-lock"
                "encrypt" = true
                "key" = "terraform.tfstate"
                "region" = "us-west-2"
                "role_arn" = "arn:aws:iam::XXXXXXXXXXXX:role/eg-gbl-root-terraform"
                "workspace_key_prefix" = "efs"
              }
              "backend_type" = "s3"
              "vars" = {
                "environment" = "uw2"
                "namespace" = "eg"
                "region" = "us-west-2"
                "stage" = "dev"
              }
            }
            "sso" = {
              "backend" = {
                "acl" = "bucket-owner-full-control"
                "bucket" = "eg-uw2-root-tfstate"
                "dynamodb_table" = "eg-uw2-root-tfstate-lock"
                "encrypt" = true
                "key" = "terraform.tfstate"
                "region" = "us-west-2"
                "role_arn" = null
                "workspace_key_prefix" = "sso"
              }
              "backend_type" = "s3"
              "vars" = {
                "environment" = "uw2"
                "namespace" = "eg"
                "region" = "us-west-2"
                "stage" = "dev"
              }
            }
            "tfstate-backend" = {
              "backend" = {
                "acl" = "bucket-owner-full-control"
                "bucket" = "eg-uw2-root-tfstate"
                "dynamodb_table" = "eg-uw2-root-tfstate-lock"
                "encrypt" = true
                "key" = "terraform.tfstate"
                "region" = "us-west-2"
                "role_arn" = null
                "workspace_key_prefix" = "tfstate-backend"
              }
              "backend_type" = "s3"
              "vars" = {
                "environment" = "uw2"
                "namespace" = "eg"
                "region" = "us-west-2"
                "stage" = "dev"
              }
            }
            "vpc" = {
              "backend" = {
                "acl" = "bucket-owner-full-control"
                "bucket" = "eg-uw2-root-tfstate"
                "dynamodb_table" = "eg-uw2-root-tfstate-lock"
                "encrypt" = true
                "key" = "terraform.tfstate"
                "region" = "us-west-2"
                "role_arn" = "arn:aws:iam::XXXXXXXXXXXX:role/eg-gbl-root-terraform"
                "workspace_key_prefix" = "vpc"
              }
              "backend_type" = "s3"
              "vars" = {
                "availability_zones" = [
                  "us-west-2b",
                  "us-west-2c",
                  "us-west-2d",
                ]
                "cidr_block" = "10.114.0.0/18"
                "environment" = "uw2"
                "namespace" = "eg"
                "region" = "us-west-2"
                "stage" = "dev"
                "subnet_type_tag_key" = "eg.com/subnet/type"
                "vpc_flow_logs_bucket_environment_name" = "uw2"
                "vpc_flow_logs_bucket_stage_name" = "audit"
                "vpc_flow_logs_enabled" = true
                "vpc_flow_logs_traffic_type" = "ALL"
              }
            }
            "vpc-flow-logs-bucket" = {
              "backend" = {
                "acl" = "bucket-owner-full-control"
                "bucket" = "eg-uw2-root-tfstate"
                "dynamodb_table" = "eg-uw2-root-tfstate-lock"
                "encrypt" = true
                "key" = "terraform.tfstate"
                "region" = "us-west-2"
                "role_arn" = "arn:aws:iam::XXXXXXXXXXXX:role/eg-gbl-root-terraform"
                "workspace_key_prefix" = "vpc-flow-logs-bucket"
              }
              "backend_type" = "s3"
              "vars" = {
                "environment" = "uw2"
                "namespace" = "eg"
                "region" = "us-west-2"
                "stage" = "dev"
              }
            }
          }
        }
      }
  ]
  ```
