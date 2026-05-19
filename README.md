# learn-argocd

A GitOps practice repo: deploy a "hello world" nginx to a `kind` cluster via ArgoCD.

## Structure

```
learn-argocd/
├── manifests/                 # Application manifests (what ArgoCD deploys)
│   ├── nonprod/hello-nginx/
│   │   ├── deployment.yaml     # nginx, namespace hello-nginx-nonprod
│   │   └── service.yaml
│   └── prod/hello-nginx/
│       ├── deployment.yaml     # nginx, namespace hello-nginx-prod
│       └── service.yaml
└── argocd/                    # ArgoCD Application definitions (CRD)
    ├── hello-nginx-nonprod.yaml
    └── hello-nginx-prod.yaml
```

GitOps concept: `manifests/` is the *desired state* stored in Git.
ArgoCD reads this repo and reconciles the cluster to match what is in Git.
The files in `argocd/` register which repo and path ArgoCD should watch.

## Usage

1. Push this repo to GitHub (branch `master`).
2. Register both Applications with ArgoCD:

   ```sh
   kubectl apply -f argocd/
   ```

3. Open the ArgoCD UI — `hello-nginx-nonprod` and `hello-nginx-prod` will
   appear and sync automatically (`syncPolicy.automated`).

4. Check the result:

   ```sh
   kubectl get pods -n hello-nginx-nonprod
   kubectl get pods -n hello-nginx-prod
   ```

## Accessing the ArgoCD UI

```sh
kubectl port-forward svc/argocd-server -n argocd 8080:443
# open https://localhost:8080
# admin password:
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath='{.data.password}' | base64 -d; echo
```

## Notes

The `nonprod` and `prod` folders are intentionally near-identical (only the
namespace/labels differ) for learning purposes. In a real project you would
use Kustomize overlays or Helm values instead of duplicating YAML.
