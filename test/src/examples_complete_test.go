package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.tfvars"},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	vars := terraform.OutputMap(t, terraformOptions, "vars")
	// Verify we're getting back the outputs we expect
	assert.Greater(t, len(vars), 0)

	// Run `terraform output` to get the value of an output variable
	settings := terraform.OutputMap(t, terraformOptions, "settings")
	// Verify we're getting back the outputs we expect
	assert.Greater(t, len(settings), 0)

	// Run `terraform output` to get the value of an output variable
	env := terraform.OutputMap(t, terraformOptions, "env")
	// Verify we're getting back the outputs we expect
	assert.Greater(t, len(env), 0)

	// Run `terraform output` to get the value of an output variable
	stackName := terraform.Output(t, terraformOptions, "stack_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "my-stack", stackName)
}
