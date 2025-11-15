This repository contains the complete infrastructure and CI/CD configuration for deploying a containerized Python (Flask) application to Google Kubernetes Engine (GKE). The project was built from scratch to demonstrate a professional, end-to-end, fully automated DevOps workflow using modern, world-class principles.

## Architecture Diagram

```
[ GitHub ] -> [ Cloud Build ] -> [ Terraform ] -> [ Helm ] -> [ Google Kubernetes Engine ]
(Source Control) (CI/CD Pipeline) (Infrastructure) (Deployment)    (Staging & Prod Env)
```

## Technology Stack

  * Cloud Provider: Google Cloud Platform (GCP)
  * Containerization: Docker
  * Container Orchestration: Google Kubernetes Engine (GKE)
  * Infrastructure as Code (IaC): Terraform
  * CI/CD Automation: Google Cloud Build (using v2 Connections API)
  * Kubernetes Packaging: Helm
  * Application: Python (Flask) with a Gunicorn production server

## Key Features & DevOps Principles

This project is a showcase of modern DevOps best practices:

  * 100% Infrastructure as Code: Every component of the cloud environment—including the VPC, GKE cluster, IAM service accounts, Artifact Registry, and the CI/CD triggers themselves—is defined declaratively with Terraform for a fully repeatable and version-controlled setup.
  * Sophisticated CI/CD Pipeline: A multi-stage pipeline built with Google Cloud Build automates the entire process from code commit to a running application.
  * Git-Based Release Workflow (GitOps):
      * Pushes to the `main` branch automatically deploy to a sandboxed staging environment for verification.
      * The creation of a semantic version tag (e.g., `v1.0.1`) triggers a release candidate for the production environment.
  * Manual Approval Gate for Production: The production trigger is configured with a real, enforceable manual approval gate within the Cloud Build UI, providing a critical safety check before releasing to users.
  * Automated Quality Checks ("Shift Left"): A separate, fast pipeline runs on every Pull Request to perform linting, ensuring code quality and style consistency before it is merged into the main branch.
  * Containerized & Declarative Deployments: The Python application is packaged into an optimized, multi-stage Docker container. Its deployment to Kubernetes is managed declaratively with a Helm chart, allowing for predictable and version-controlled releases.
  * High Availability & Resilience: The GKE deployment is configured for production readiness with:
      * Health Probes: `liveness` and `readiness` probes to ensure traffic is only sent to healthy pods and that failing pods are automatically restarted.
      * Autoscaling: A Horizontal Pod Autoscaler (HPA) to automatically scale the number of pods based on CPU load.
  * Secure by Design:
      * Principle of Least Privilege: Utilizes multiple, specialized IAM Service Accounts for different components (GKE nodes, Cloud Build, the application itself).
      * Workload Identity: Implements Google Cloud's modern, keyless authentication mechanism to securely grant pods access to other cloud resources.

## The Debugging Journey

A significant part of this project was the real-world debugging process required to integrate the new Cloud Build v2 APIs. This involved diagnosing and solving a series of complex, layered issues related to:

  * Terraform provider versions and argument mismatches (`parent_connection` vs. `connection`).
  * API prerequisites and race conditions (`depends_on`).
  * Regional vs. Global resource locations.
  * The `OAuth` and `GitHub App` authorization flow.
  * Debugging live Kubernetes resources by analyzing `ImagePullBackOff` errors and "stuck" namespaces.

The final, successful solution is a testament to a methodical, evidence-based approach to solving complex cloud infrastructure problems.
