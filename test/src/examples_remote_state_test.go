package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesRemoteState(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/remote-state",
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

	terraform.OutputStruct(t, terraformOptions, "remote_state_using_stack", &output)
	remoteStateUsingStack := output.(map[string]interface{})

	// Verify we're getting back the outputs we expect
	assert.NotNilf(t, remoteStateUsingStack, "remote state is empty")
	assert.Equal(t, float64(1), remoteStateUsingStack["val1"])
	assert.Equal(t, "2", remoteStateUsingStack["val2"])
	assert.Equal(t, true, remoteStateUsingStack["val3"])
	assert.Equal(t, "", remoteStateUsingStack["val4"])
	assert.Equal(t, nil, remoteStateUsingStack["val5"])

	terraform.OutputStruct(t, terraformOptions, "remote_state_using_context", &output)
	remoteStateUsingContext := output.(map[string]interface{})

	// Verify we're getting back the outputs we expect
	assert.NotNilf(t, remoteStateUsingContext, "remote state is empty")
	assert.Equal(t, float64(1), remoteStateUsingContext["val1"])
	assert.Equal(t, "2", remoteStateUsingContext["val2"])
	assert.Equal(t, true, remoteStateUsingContext["val3"])
	assert.Equal(t, "", remoteStateUsingContext["val4"])
	assert.Equal(t, nil, remoteStateUsingContext["val5"])
}
