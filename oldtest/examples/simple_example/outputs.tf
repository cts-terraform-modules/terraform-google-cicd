
output "repo" {
  value       = module.cicd.sourcerepo_repository
  description = "The Cloud Source Repositories repo created."
}

output "trigger" {
  value       = module.cicd.cloudbuild_trigger
  description = "The Cloud Build Trigger created."
}
