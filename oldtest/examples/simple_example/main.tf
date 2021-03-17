
module "cicd" {
  source = "../../"

  trigger_description = "Builds the kms-secrets-operator image."
  repo_name           = "kms-secrets-operator"
  project             = var.project
  ignored_files = [
    ".gitignore",
  ]
  branch_name = "master"
  images = [
    "gcr.io/$PROJECT_ID/kms-secrets-operator:$COMMIT_SHA"
  ]
  timeout = "900s"
  build_tags = [
    "kms-secrets-operator",
    "image",
    "build"
  ]
  steps = [
    {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "build",
        "-t",
        "gcr.io/$PROJECT_ID/kms-secrets-operator:$COMMIT_SHA",
        "."
      ]
      env        = []
      id         = ""
      entrypoint = ""
      dir        = ""
      timeout    = ""
      volumes    = []
      wait_for   = []
    }
  ]
}
