
output "bucket_name" {
  description = "The name of the bucket."
  value       = module.example.bucket_name
}

output "project_id" {
  description = "The ID of the project in which resources are provisioned."
  value       = var.project_id
}
