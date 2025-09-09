resource "google_artifact_registry_repository" "app_repo" {
   project = var.project_id
   location = var.region
   repository_id = "python-api-repo"
   format = "DOCKER"
   description = "Terraform-managed Docker repo for Python-api"  

}
