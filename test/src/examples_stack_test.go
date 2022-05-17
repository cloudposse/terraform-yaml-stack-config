package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

// Test the Terraform module in examples/stack using Terratest.
func TestExamplesStack(t *testing.T) {

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/stack",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.tfvars"},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	stack1Name := terraform.Output(t, terraformOptions, "stack_1_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "my-stack", stack1Name)

	// Run `terraform output` to get the value of an output variable
	stack2Name := terraform.Output(t, terraformOptions, "stack_2_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "my-stack", stack2Name)

	// Run `terraform output` to get the value of an output variable
	stack3Name := terraform.Output(t, terraformOptions, "stack_3_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "uw2-dev", stack3Name)

	// Run `terraform output` to get the value of an output variable
	stack4Name := terraform.Output(t, terraformOptions, "stack_4_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "acme-uw2-dev", stack4Name)

	// Run `terraform output` to get the value of an output variable
	stack5Name := terraform.Output(t, terraformOptions, "stack_5_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "acme-uw2-dev", stack5Name)

	// Run `terraform output` to get the value of an output variable
	stack6Name := terraform.Output(t, terraformOptions, "stack_6_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "dev-uw2-acme", stack6Name)

	// Run `terraform output` to get the value of an output variable
	stack7Name := terraform.Output(t, terraformOptions, "stack_7_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "uw2-acme-dev", stack7Name)

	// Run `terraform output` to get the value of an output variable
	stack8Name := terraform.Output(t, terraformOptions, "stack_8_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "dev-acme-uw2", stack8Name)

	// Run `terraform output` to get the value of an output variable
	stack9Name := terraform.Output(t, terraformOptions, "stack_9_name")
	// Verify we're getting back the outputs we expect
	assert.Equal(t, "my-stack", stack9Name)
}
