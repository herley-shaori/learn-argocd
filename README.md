# Learn Argo CD

This repository is a small starter note for learning Argo CD.

## What is Argo CD?

Argo CD is a GitOps continuous delivery tool for Kubernetes.  
You store your desired Kubernetes manifests in Git, and Argo CD keeps your cluster synced to that desired state.

## Basic learning path

1. Install Argo CD in a Kubernetes cluster.
2. Access the Argo CD UI/API server.
3. Register a Git repository that contains Kubernetes manifests.
4. Create an `Application` in Argo CD that points to that repository path.
5. Sync the application and observe health/sync status.

## Useful next topics

- Auto-sync and pruning
- Multi-environment application setup
- RBAC and SSO
- ApplicationSets
