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
  required_version = "0.12.13"
}

provider "google" {
  version = "2.14.0"
}

module "cicd" {
  source = "../../"

  trigger_description = "Builds the tester image."
  repo_name           = "tester"
  create_repo         = true
  repo_dir            = "kustomize"
  project             = var.project
  ignored_files = [
    ".gitignore",
  ]
  branch_name = "master"
  images = [
    "gcr.io/$PROJECT_ID/tester:$COMMIT_SHA"
  ]
  build_tags = [
    "image",
    "build"
  ]
  steps = [
    {
      name = "gcr.io/cloud-builders/docker"
      args = [
        "build",
        "-t",
        "gcr.io/$PROJECT_ID/tester:$COMMIT_SHA",
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
