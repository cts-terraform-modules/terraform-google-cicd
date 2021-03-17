terraform {
  required_version = "~> 0.12.0"
}

// cloud source repository
resource "google_sourcerepo_repository" "default" {
  count   = var.create_repo ? 1 : 0
  name    = var.repo_name
  project = var.project
}

resource "google_cloudbuild_trigger" "default" {
  description    = var.trigger_description
  project        = var.project
  disabled       = var.disabled
  substitutions  = var.substitutions
  filename       = var.filename
  ignored_files  = var.ignored_files
  included_files = var.included_files
  trigger_template {
    project_id  = var.project
    repo_name   = var.repo_name
    dir         = var.source_dir
    branch_name = var.branch_name
    tag_name    = var.tag_name
    commit_sha  = var.commit_sha
  }
  build {
    tags    = var.build_tags
    images  = var.images
    timeout = var.timeout
    dynamic "step" {
      for_each = var.steps
      content {
        name       = lookup(step.value, "name", null)
        args       = lookup(step.value, "args", [])
        env        = lookup(step.value, "env", [])
        id         = lookup(step.value, "id", null)
        entrypoint = lookup(step.value, "entrypoint", null)
        dir        = lookup(step.value, "dir", null)
        timeout    = lookup(step.value, "timeout", null)
        dynamic "volumes" {
          for_each = lookup(step.value, "volumes", [])
          content {
            name = lookup(volumes.value, "name", null)
            path = lookup(volumes.value, "path", null)
          }
        }
        wait_for = lookup(step.value, "wait_for", [])
      }
    }
  }
}
