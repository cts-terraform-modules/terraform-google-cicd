/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

terraform {
  required_version = "~> 0.12.0"
}

// cloud source repository
resource "google_sourcerepo_repository" "default" {
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
    project_id  = google_sourcerepo_repository.default.project
    repo_name   = google_sourcerepo_repository.default.name
    dir         = var.source_dir
    branch_name = var.branch_name
    tag_name    = var.tag_name
    commit_sha  = var.commit_sha
  }
  build {
    tags   = var.build_tags
    images = var.images
    dynamic "step" {
      for_each = var.steps
      content {
        name       = step.value["name"]
        args       = step.value["args"]
        env        = step.value["env"]
        id         = step.value["id"]
        entrypoint = step.value["entrypoint"]
        dir        = step.value["dir"]
        timeout    = step.value["timeout"]
        dynamic "volumes" {
          for_each = step.value["volumes"]
          content {
            name = volumes.value["name"]
            path = volumes.value["path"]
          }
        }
        wait_for   = step.value["wait_for"]
      }
    }
  }
}
