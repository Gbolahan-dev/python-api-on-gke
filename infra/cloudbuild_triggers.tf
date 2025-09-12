resource "google_cloudbuildv2_connection" "github_connection" {
  provider = google-beta
  project  = var.project_id
  location = var.region
  name     = "github-connection"

  github_config {
    app_installation_id = var.github_app_installation_id
  }
  depends_on = [google_project_service.apis]
  lifecycle { ignore_changes = [github_config] }
}

resource "google_cloudbuildv2_repository" "github_repo" {
  project           = var.project_id
  provider          = google-beta
  location          = var.region
  # This is the corrected argument, based on the error message
  name              = var.cloudbuild_repo_id
  parent_connection = google_cloudbuildv2_connection.github_connection.name
  remote_uri        = "https://github.com/${var.github_owner}/${var.github_repo_name_on_github}.git"
  depends_on        = [google_project_service.apis]
}

resource "google_cloudbuild_trigger" "prod" {
  project  = var.project_id
  location = var.region
  name     = "python-api-prod-trigger"
  filename = "cloudbuild.yaml"
 
  service_account = "projects/${var.project_id}/serviceAccounts/${var.cb_runner_sa_email}"
  repository_event_config {
    repository = google_cloudbuildv2_repository.github_repo.id
    push {
      branch = "^main$"
    }
  }
}

resource "google_cloudbuild_trigger" "pr" {
  project =   var.project_id
  location = var.region
  name     = "python-api-pr-trigger"
  filename = "cloudbuild.pr.yaml"

  service_account = "projects/${var.project_id}/serviceAccounts/${var.cb_runner_sa_email}"
  repository_event_config {
    repository = google_cloudbuildv2_repository.github_repo.id
    pull_request {
      branch = "^main$"
    }
  }
}
