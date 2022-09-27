package test

import (
	"crypto/tls"
	"fmt"
	"strings"
	"testing"
	"time"

	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestHttp(t *testing.T) {
	t.Parallel()
	repoPath := ".."
	varFiles := retrieveVarFiles(t)
	timestamp := createTimestamp()

	testCases := []*struct {
		name     string
		url      string
		expected string
	}{
		{
			name:     "Server",
			url:      "https://nextjs-grpc.utkusarioglu.com",
			expected: "Server",
		},
		{
			name:     "address",
			url:      "https://nextjs-grpc.utkusarioglu.com",
			expected: "address",
		},
	}

	test_structure.RunTestStage(t, "setup", func() {
		terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
			TerraformDir: repoPath,
			VarFiles:     varFiles,
			EnvVars: map[string]string{
				"TF_LOG_PATH": fmt.Sprintf("logs/%s.terratest.log", timestamp),
				"TF_LOG":      "DEBUG",
			},
		})
		test_structure.SaveTerraformOptions(t, ".", terraformOptions)
		terraform.InitAndApply(t, terraformOptions)
	})

	test_structure.RunTestStage(t, "validate", func() {
		t.Run("group", func(t *testing.T) {
			for _, testCase := range testCases {
				testCase := testCase
				t.Run(testCase.name, func(t *testing.T) {
					t.Parallel()
					validateResponse := func(status_code int, response_text string) bool {
						return strings.Contains(response_text, testCase.expected)
					}

					tls_config := &tls.Config{
						// InsecureSkipVerify: true,
					}

					http_helper.HttpGetWithRetryWithCustomValidation(
						t,
						testCase.url,
						tls_config,
						100,
						10*time.Second,
						validateResponse,
					)
				})
			}
		})
	})

	test_structure.RunTestStage(t, "teardown", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, ".")
		terraform.Destroy(t, terraformOptions)
	})
}
