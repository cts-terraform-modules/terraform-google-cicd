# terraform-google-cicd

This module was generated from
[terraform-google-module-template](https://github.com/terraform-google-modules/terraform-google-module-template/),
which by default generates a module that simply creates a GCS bucket. As the
module develops, this README should be updated.

The resources/services/activations/deletions that this module will
create/trigger are:

-   Create a GCS bucket with the provided name

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
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [google_cloudbuild_trigger](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_trigger) |
| [google_project_service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) |
| [google_sourcerepo_repository](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sourcerepo_repository) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| branch\_name | (Optional) Name of the branch to build. Exactly one a of branch name, tag, or commit SHA must be provided. | `any` | `null` | no |
| build\_tags | (Optional) Tags for annotation of a Build. These are not docker tags. | `any` | `null` | no |
| commit\_sha | (Optional) Explicit commit SHA to build. Exactly one of a branch name, tag, or commit SHA must be provided. | `any` | `null` | no |
| create\_repo | (Optional) If create\_repo is set to true, the Cloud Source Repository will be created. | `bool` | `true` | no |
| disabled | (Optional) Whether the trigger is disabled or not. If true, the trigger will never result in a build. | `any` | `null` | no |
| filename | (Optional) Path, from the source root, to a file whose contents is used for the template. Either a filename or build template must be provided. | `any` | `null` | no |
| ignored\_files | (Optional) A list of files to be ignored by the trigger (Golang style globbing). | `any` | `null` | no |
| images | (Optional) A list of images to be pushed upon the successful completion of all build steps. | `any` | `null` | no |
| included\_files | (Optional) A list of files to be specifically included (Golang style globbing). | `any` | `null` | no |
| project | (Optional) The ID of the project in which the Cloud Build should be deployed. If it is not provided, the provider project is used. | `any` | `null` | no |
| repo\_name | (Required) Resource name of the repository, of the form {{repo}}. The repo name may contain slashes. eg, name/with/slash | `any` | n/a | yes |
| source\_dir | (Optional) Directory, relative to the source root, in which to run the build. This must be a relative path. If a step's dir is specified and is an absolute path, this value is ignored for that step's execution. | `any` | `null` | no |
| steps | (Optional) A list of objects which define operations to be performed on the workspace. | <pre>list(object({<br>    name       = string<br>    args       = list(string)<br>    env        = list(string)<br>    id         = string<br>    entrypoint = string<br>    dir        = string<br>    timeout    = string<br>    volumes = list(object({<br>      name = string<br>      path = string<br>    }))<br>    wait_for = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "args": [],<br>    "dir": null,<br>    "entrypoint": null,<br>    "env": [],<br>    "id": null,<br>    "name": null,<br>    "timeout": null,<br>    "volumes": [],<br>    "wait_for": []<br>  }<br>]</pre> | no |
| substitutions | (Optional) Substitutions data for Build resource. | `map(string)` | `null` | no |
| tag\_name | (Optional) Name of the tag to build. Exactly one of a branch name, tag, or commit SHA must be provided. | `any` | `null` | no |
| timeout | (Optional) Max timeout value for the build in seconds | `any` | `null` | no |
| trigger\_description | (Optional) Human-readable description of the trigger. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudbuild\_trigger | n/a |
| sourcerepo\_repository | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Prerequisites

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

-   [Terraform][terraform] v0.12
-   [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.1

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

-   Cloud Build Editor: `roles/cloudbuild.builds.editor`
-   Source Repositories Admin: `roles/source.admin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

-   Cloud Source Repositories API: `sourcerepo.googleapis.com`
-   Cloud Build API: `cloudbuild.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
