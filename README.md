# terraform-google-cicd

This module was generated from [terraform-google-module-template](https://github.com/terraform-google-modules/terraform-google-module-template/), which by default generates a module that simply creates a GCS bucket. As the module develops, this README should be updated.

The resources/services/activations/deletions that this module will create/trigger are:

- Create a GCS bucket with the provided name

## Usage

Basic usage of this module is as follows:

```hcl
module "cicd" {
  source  = "terraform-google-modules/cicd/google"
  version = "~> 0.1"

  project  = "<PROJECT ID>"
  repo_name = "test-repo"
  create_repo = true
  trigger_description = "Test build trigger."
  disabled = false
  substitutions {
    _ENV = "prod"
  }
  filename = "cloudbuild.yaml"
  ignored_files = [
    "**/.gitignore",
    "**/README.md"
  ]
  branch_name = "master"
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| branch\_name | (Optional) Name of the branch to build. Exactly one a of branch name, tag, or commit SHA must be provided. | string | `"null"` | no |
| build\_tags | (Optional) Tags for annotation of a Build. These are not docker tags. | string | `"null"` | no |
| commit\_sha | (Optional) Explicit commit SHA to build. Exactly one of a branch name, tag, or commit SHA must be provided. | string | `"null"` | no |
| create\_repo | (Optional) If create_repo is set to true, the Cloud Source Repository will be created. | string | `"true"` | no |
| disabled | (Optional) Whether the trigger is disabled or not. If true, the trigger will never result in a build. | string | `"null"` | no |
| filename | (Optional) Path, from the source root, to a file whose contents is used for the template. Either a filename or build template must be provided. | string | `"null"` | no |
| ignored\_files | (Optional) A list of files to be ignored by the trigger (Golang style globbing). | string | `"null"` | no |
| images | (Optional) A list of images to be pushed upon the successful completion of all build steps. | string | `"null"` | no |
| timeout | (Optional) Max timeout value for the build in seconds | string | `"null"` | no |
| included\_files | (Optional) A list of files to be specifically included (Golang style globbing). | string | `"null"` | no |
| project | (Optional) The ID of the project in which the Cloud Build should be deployed. If it is not provided, the provider project is used. | string | `"null"` | no |
| repo\_name | (Required) Resource name of the repository, of the form {{repo}}. The repo name may contain slashes. eg, name/with/slash | string | n/a | yes |
| source\_dir | (Optional) Directory, relative to the source root, in which to run the build. This must be a relative path. If a step's dir is specified and is an absolute path, this value is ignored for that step's execution. | string | `"null"` | no |
| steps | (Optional) A list of objects which define operations to be performed on the workspace. | object | `"null"` | no |
| substitutions | (Optional) Substitutions data for Build resource. | map(string) | `"null"` | no |
| tag\_name | (Optional) Name of the tag to build. Exactly one of a branch name, tag, or commit SHA must be provided. | string | `"null"` | no |
| trigger\_description | (Optional) Human-readable description of the trigger. | string | `"null"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudbuild\_trigger |  |
| sourcerepo\_repository |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.12
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v2.0

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- Cloud Build Editor: `roles/cloudbuild.builds.editor`
- Source Repositories Admin: `roles/source.admin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Cloud Source Repositories API: `sourcerepo.googleapis.com`
- Cloud Build API: `cloudbuild.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
