#!/usr/bin/env bash
# Open the ArgoCD UI: print admin credentials, then port-forward to localhost:8080.
# Keep this terminal running while you use the UI. Press Ctrl+C to stop.
set -euo pipefail

NAMESPACE="argocd"
LOCAL_PORT="8080"

password="$(kubectl -n "$NAMESPACE" get secret argocd-initial-admin-secret \
  -o jsonpath='{.data.password}' | base64 -d)"

echo "ArgoCD UI : https://localhost:${LOCAL_PORT}"
echo "Username  : admin"
echo "Password  : ${password}"
echo
echo "Starting port-forward (Ctrl+C to stop)..."
kubectl port-forward svc/argocd-server -n "$NAMESPACE" "${LOCAL_PORT}:443"
