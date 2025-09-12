# infra/variables.tf

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region for resources"
  type        = string
  default     = "us-central1"
}


# This variable is required by cloudbuild_triggers.tf
variable "github_owner" {
  description = "The owner of the GitHub repository."
  type        = string
  default     = "Gbolahan-dev"
}

# This variable is required by cloudbuild_triggers.tf
variable "github_repo_name" {
  description = "The name of the GitHub repository."
  type        = string
  default     = "python-api-on-gke"
}

# This variable is required by helm.tf and passed in by cloudbuild.yaml
variable "image_tag" {
  description = "The Docker image tag to deploy."
  type        = string
  default     = "latest"
}

 variable "cluster_name" {
   description = "Name of the GKE cluster"
   type        = string
  default     = "python-gke-cluster"      # ← match the actual name
 }

variable "zone" {
  description = "GKE cluster zone"
  type        = string
  default     = "us-central1-a"           # ← where you ran `gcloud container clusters create`
}
variable "github_app_installation_id" {
      description = "The numeric ID for the installed Google Cloud Build GitHub App."
      type        = number
}
# Cloud Build repository resource ID (safe, no leading '-')
variable "cloudbuild_repo_id" {
  type    = string
  default = "python-api-on-gke"
}

# Actual GitHub repo name (yours starts with a leading '-')
variable "github_repo_name_on_github" {
  type    = string
  default = "-python-api-on-gke"
}
variable "cb_runner_sa_email" {
  description = "Service account email Cloud Build will use"
  type        = string
  default     = "python-cb-sa@dotted-aileron-471607-m2.iam.gserviceaccount.com"
}
