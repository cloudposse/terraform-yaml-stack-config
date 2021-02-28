package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesStacks(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/stacks",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.tfvars"},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	var output interface{}
	terraform.OutputStruct(t, terraformOptions, "config", &output)
	config := output.([]interface{})

	// Verify we're getting back the outputs we expect
	assert.Equal(t, 4, len(config))
	uatConfig := config[3].(map[string]interface{})
	uatComponents := uatConfig["components"].(map[string]interface{})
	uatTerraformComponents := uatComponents["terraform"].(map[string]interface{})
	auroraPostgresComponent := uatTerraformComponents["aurora-postgres"].(map[string]interface{})
	auroraPostgres2Component := uatTerraformComponents["aurora-postgres-2"].(map[string]interface{})
	auroraPostgresWorkspace := auroraPostgresComponent["workspace"]
	auroraPostgres2Workspace := auroraPostgres2Component["workspace"]
	assert.Equal(t, "uw2-uat", auroraPostgresWorkspace)
	assert.Equal(t, "uw2-uat-aurora-postgres-2", auroraPostgres2Workspace)
}
