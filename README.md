# learn-argocd

Latihan GitOps: deploy "hello world" nginx ke cluster `kind` lewat ArgoCD.

## Struktur

```
learn-argocd/
├── manifests/                 # Manifest aplikasi (yang di-deploy ArgoCD)
│   ├── nonprod/hello-nginx/
│   │   ├── deployment.yaml     # nginx, namespace hello-nginx-nonprod
│   │   └── service.yaml
│   └── prod/hello-nginx/
│       ├── deployment.yaml     # nginx, namespace hello-nginx-prod
│       └── service.yaml
└── argocd/                    # Definisi ArgoCD Application (CRD)
    ├── hello-nginx-nonprod.yaml
    └── hello-nginx-prod.yaml
```

Konsep GitOps: `manifests/` adalah *desired state* yang disimpan di Git.
ArgoCD membaca repo ini, lalu menyamakan isi cluster dengan isi Git.
File di `argocd/` mendaftarkan repo + path mana yang harus ArgoCD pantau.

## Cara pakai

1. Push repo ini ke GitHub.
2. Daftarkan kedua Application ke ArgoCD:

   ```sh
   kubectl apply -f argocd/
   ```

3. Buka ArgoCD UI — `hello-nginx-nonprod` dan `hello-nginx-prod` akan muncul
   dan ter-sync otomatis (`syncPolicy.automated`).

4. Cek hasilnya:

   ```sh
   kubectl get pods -n hello-nginx-nonprod
   kubectl get pods -n hello-nginx-prod
   ```

## Akses ArgoCD UI

```sh
kubectl port-forward svc/argocd-server -n argocd 8080:443
# buka https://localhost:8080
# password admin:
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath='{.data.password}' | base64 -d; echo
```

## Catatan

Folder `nonprod` dan `prod` sengaja isinya hampir sama (beda namespace/label)
untuk tujuan belajar. Di proyek nyata, biasanya pakai Kustomize overlay atau
Helm values agar tidak menduplikasi YAML.
