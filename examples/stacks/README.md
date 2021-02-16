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
              "env" = {}
              "settings" = {}
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
              "env" = {}
              "settings" = {}
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
            "datadog" = {
              "env" = {
                "ENV_DD_TEST_1" = "dd1"
                "ENV_DD_TEST_2" = "dd2"
                "ENV_DD_TEST_3" = "dd3"
              }
              "settings" = {}
              "vars" = {
                "account_number" = "1234567890"
                "apm" = {
                  "enabled" = true
                }
                "clusterAgent" = {
                  "enabled" = true
                }
                "datadogTags" = [
                  "env:uw2-dev",
                  "region:us-west-2",
                  "stage:dev",
                ]
                "environment" = "uw2"
                "installed" = true
                "namespace" = "eg"
                "processAgent" = {
                  "enabled" = true
                }
                "region" = "us-west-2"
                "ssm_region" = "us-west-2"
                "stage" = "dev"
                "systemProbe" = {
                  "enabled" = true
                }
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
              "env" = {
                "ENV_TEST_1" = "test1"
                "ENV_TEST_2" = "test2"
                "ENV_TEST_3" = "test3"
              }
              "settings" = {
                "spacelift" = {
                  "autodeploy" = false
                  "workspace_enabled" = false
                }
                "version" = 0
              }
              "vars" = {
                "environment" = "uw2"
                "namespace" = "eg"
                "region" = "us-west-2"
                "stage" = "dev"
              }
              "workspace" = "uw2-dev"
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
              "env" = {
                "ENV_TEST_1" = "test1"
                "ENV_TEST_2" = "test2"
                "ENV_TEST_3" = "test3"
                "ENV_TEST_4" = "test4"
                "ENV_TEST_5" = "test5"
                "ENV_TEST_6" = "test6"
                "ENV_TEST_7" = "test7"
              }
              "settings" = {
                "spacelift" = {
                  "autodeploy" = false
                  "workspace_enabled" = false
                }
                "version" = 0
              }
              "vars" = {
                "cluster_size" = 1
                "environment" = "uw2"
                "instance_type" = "db.r4.large"
                "namespace" = "eg"
                "region" = "us-west-2"
                "stage" = "dev"
              }
              "workspace" = "uw2-dev"
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
              "component" = "aurora-postgres"
              "env" = {
                "ENV_TEST_1" = "test1_override2"
                "ENV_TEST_2" = "test2_override2"
                "ENV_TEST_3" = "test3"
                "ENV_TEST_4" = "test4"
                "ENV_TEST_5" = "test5"
                "ENV_TEST_6" = "test6"
                "ENV_TEST_7" = "test7"
                "ENV_TEST_8" = "test8"
              }
              "settings" = {
                "spacelift" = {
                  "autodeploy" = true
                  "branch" = "dev"
                  "triggers" = []
                  "workspace_enabled" = true
                }
                "version" = 0
              }
              "vars" = {
                "cluster_size" = 1
                "environment" = "uw2"
                "instance_type" = "db.r4.xlarge"
                "namespace" = "eg"
                "region" = "us-west-2"
                "stage" = "dev"
              }
              "workspace" = "uw2-dev-aurora-postgres-2"
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
              "env" = {
                "ENV_TEST_1" = "test1"
                "ENV_TEST_2" = "test2"
                "ENV_TEST_3" = "test3"
              }
              "settings" = {
                "spacelift" = {
                  "autodeploy" = true
                  "branch" = ""
                  "triggers" = []
                  "workspace_enabled" = true
                }
                "version" = 0
              }
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
              "workspace" = "uw2-dev"
            }
            "eks" = {
              "backend" = {
                "acl" = "bucket-owner-full-control"
                "bucket" = "eg-uw2-root-tfstate"
                "dynamodb_table" = "eg-uw2-root-tfstate-lock"
                "encrypt" = true
                "key" = "terraform.tfstate"
                "region" = "us-west-2"
                "role_arn" = "arn:aws:iam::XXXXXXXXXXXX:role/eg-gbl-root-terraform"
                "workspace_key_prefix" = "eks"
              }
              "backend_type" = "s3"
              "env" = {
                "ENV_TEST_1" = "test1_override"
                "ENV_TEST_2" = "test2_override"
                "ENV_TEST_3" = "test3"
                "ENV_TEST_4" = "test4"
              }
              "settings" = {
                "spacelift" = {
                  "autodeploy" = true
                  "branch" = "test"
                  "triggers" = []
                  "workspace_enabled" = true
                }
                "version" = 0
              }
              "vars" = {
                "environment" = "uw2"
                "namespace" = "eg"
                "region" = "us-west-2"
                "region_availability_zones" = [
                  "us-west-2b",
                  "us-west-2c",
                  "us-west-2d",
                ]
                "spotinst_instance_profile" = "eg-gbl-dev-spotinst-worker"
                "spotinst_oceans" = {
                  "main" = {
                    "ami_release_version" = null
                    "ami_type" = "AL2_x86_64"
                    "attributes" = null
                    "desired_group_size" = 1
                    "disk_size" = 100
                    "instance_types" = null
                    "kubernetes_version" = null
                    "max_group_size" = 3
                    "min_group_size" = 1
                    "tags" = null
                  }
                }
                "stage" = "dev"
              }
              "workspace" = "uw2-dev"
            }
          }
        }
      }
  ]
  ```
