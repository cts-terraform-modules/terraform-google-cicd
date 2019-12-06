# Simple Example with code

This example illustrates how to use the `cicd` module, creating the repo and pushing code
straigh to it.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project | The ID of the project in which to provision resources. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| repo | The Cloud Source Repositories repo created. |
| trigger | The Cloud Build Trigger created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
