
# helm.tf
resource "helm_release" "staging" {
  name             = "python-gke-staging"
  chart            = "../charts/python-api" # Path to new chart
  namespace        = kubernetes_namespace.staging.metadata[0].name
  create_namespace = false
  atomic          = true           # auto-rollback on failure
  cleanup_on_fail = true           # remove broken release so name isn’t “stuck”
  timeout         = 900            # 15m to wait for pods to become Ready
  wait            = true 

  set {
    name  = "image.repository"
    value = "${google_artifact_registry_repository.app_repo.location}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.app_repo.repository_id}/python-api"
  }
  set {
    name  = "image.tag"
    value = var.image_tag
  }
  set {
    name  = "serviceAccount.name"
    value = "python-api-ksa"
  }
}

resource "helm_release" "production" {
  name             = "python-api-prod"
  chart            = "../charts/python-api" # Path to new chart
  namespace        = kubernetes_namespace.prod.metadata[0].name
  create_namespace = false
  atomic          = true           # auto-rollback on failure
  cleanup_on_fail = true           # remove broken release so name isn’t “stuck”
  timeout         = 900            # 15m to wait for pods to become Ready
  wait            = true

  set {
    name  = "image.repository"
    value = "${google_artifact_registry_repository.app_repo.location}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.app_repo.repository_id}/python-api"
  }
  set {
    name  = "image.tag"
    value = var.image_tag
  }
  set {
    name  = "serviceAccount.name"
    value = "python-api-ksa"
  }
}

