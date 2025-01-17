
variable "repo_name" {
  description = "(Required) Resource name of the repository, of the form {{repo}}. The repo name may contain slashes. eg, name/with/slash"
}
variable "create_repo" {
  description = "(Optional) If create_repo is set to true, the Cloud Source Repository will be created."
  default     = true
}
variable "project" {
  description = "(Optional) The ID of the project in which the Cloud Build should be deployed. If it is not provided, the provider project is used."
  default     = null
}
variable "trigger_description" {
  description = "(Optional) Human-readable description of the trigger."
  default     = null
}
variable "disabled" {
  description = "(Optional) Whether the trigger is disabled or not. If true, the trigger will never result in a build."
  default     = null
}
variable "substitutions" {
  type        = map(string)
  description = "(Optional) Substitutions data for Build resource."
  default     = null
}
variable "filename" {
  description = "(Optional) Path, from the source root, to a file whose contents is used for the template. Either a filename or build template must be provided."
  default     = null
}
variable "ignored_files" {
  description = "(Optional) A list of files to be ignored by the trigger (Golang style globbing)."
  default     = null
}
variable "included_files" {
  description = "(Optional) A list of files to be specifically included (Golang style globbing)."
  default     = null
}
variable "source_dir" {
  description = "(Optional) Directory, relative to the source root, in which to run the build. This must be a relative path. If a step's dir is specified and is an absolute path, this value is ignored for that step's execution."
  default     = null
}
variable "branch_name" {
  description = "(Optional) Name of the branch to build. Exactly one a of branch name, tag, or commit SHA must be provided."
  default     = null
}
variable "tag_name" {
  description = "(Optional) Name of the tag to build. Exactly one of a branch name, tag, or commit SHA must be provided."
  default     = null
}
variable "commit_sha" {
  description = "(Optional) Explicit commit SHA to build. Exactly one of a branch name, tag, or commit SHA must be provided."
  default     = null
}
variable "build_tags" {
  description = "(Optional) Tags for annotation of a Build. These are not docker tags."
  default     = null
}
variable "images" {
  description = "(Optional) A list of images to be pushed upon the successful completion of all build steps."
  default     = null
}
variable "timeout" {
  description = "(Optional) Max timeout value for the build in seconds"
  default     = null
}
variable "steps" {
  type = list(object({
    name       = string
    args       = list(string)
    env        = list(string)
    id         = string
    entrypoint = string
    dir        = string
    timeout    = string
    volumes = list(object({
      name = string
      path = string
    }))
    wait_for = list(string)
  }))
  description = "(Optional) A list of objects which define operations to be performed on the workspace."
  default = [
    {
      name       = null
      args       = []
      env        = []
      id         = null
      entrypoint = null
      dir        = null
      timeout    = null
      volumes    = []
      wait_for   = []
    }
  ]
}
