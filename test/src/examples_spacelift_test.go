package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesSpacelift(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/spacelift",
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
	terraform.OutputStruct(t, terraformOptions, "spacelift_stacks", &output)
	spaceliftStacks := output.(map[string]interface{})

	// Verify we're getting back the outputs we expect
	assert.Equal(t, 16, len(spaceliftStacks))

	uw2DevAuroraPostgres2Stack := spaceliftStacks["uw2-dev-aurora-postgres-2"].(map[string]interface{})

	uw2DevAuroraPostgres2StackComponent := uw2DevAuroraPostgres2Stack["component"].(string)
	uw2DevAuroraPostgres2StackBaseComponent := uw2DevAuroraPostgres2Stack["base_component"].(string)
	uw2DevAuroraPostgres2StackWorkspace := uw2DevAuroraPostgres2Stack["workspace"].(string)
	uw2DevAuroraPostgres2StackDeps := uw2DevAuroraPostgres2Stack["deps"].([]interface{})
	uw2DevAuroraPostgres2StackImports := uw2DevAuroraPostgres2Stack["imports"].([]interface{})
	uw2DevAuroraPostgres2StackLabels := uw2DevAuroraPostgres2Stack["labels"].([]interface{})

	assert.Equal(t, "aurora-postgres-2", uw2DevAuroraPostgres2StackComponent)
	assert.Equal(t, "aurora-postgres", uw2DevAuroraPostgres2StackBaseComponent)
	assert.Equal(t, "uw2-dev-aurora-postgres-2", uw2DevAuroraPostgres2StackWorkspace)

	assert.Equal(t, "globals", uw2DevAuroraPostgres2StackDeps[0])
	assert.Equal(t, "uw2-dev", uw2DevAuroraPostgres2StackDeps[1])
	assert.Equal(t, "uw2-globals", uw2DevAuroraPostgres2StackDeps[2])

	assert.Equal(t, "eks/eks-defaults", uw2DevAuroraPostgres2StackImports[0])
	assert.Equal(t, "globals", uw2DevAuroraPostgres2StackImports[1])
	assert.Equal(t, "uw2-globals", uw2DevAuroraPostgres2StackImports[2])

	assert.Equal(t, "import:stacks/eks/eks-defaults.yaml", uw2DevAuroraPostgres2StackLabels[0])
	assert.Equal(t, "import:stacks/globals.yaml", uw2DevAuroraPostgres2StackLabels[1])
	assert.Equal(t, "import:stacks/uw2-globals.yaml", uw2DevAuroraPostgres2StackLabels[2])
	assert.Equal(t, "deps:stacks/globals.yaml", uw2DevAuroraPostgres2StackLabels[3])
	assert.Equal(t, "deps:stacks/uw2-dev.yaml", uw2DevAuroraPostgres2StackLabels[4])
	assert.Equal(t, "deps:stacks/uw2-globals.yaml", uw2DevAuroraPostgres2StackLabels[5])
	assert.Equal(t, "folder:component/aurora-postgres-2", uw2DevAuroraPostgres2StackLabels[6])
	assert.Equal(t, "folder:uw2/dev", uw2DevAuroraPostgres2StackLabels[8])
}
