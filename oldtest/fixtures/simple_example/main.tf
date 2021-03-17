
resource "random_pet" "main" {
  length    = 1
  prefix    = "simple-example"
  separator = "-"
}

module "example" {
  source = "../../../examples/simple_example"

  project_id  = var.project_id
  bucket_name = random_pet.main.id
}
