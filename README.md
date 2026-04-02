# Homelab

Infrastructure auto-hébergée pour la colocation.
Stack : K3s · Terraform · GitHub Actions · ArgoCD

## Stack technique
- **Cluster** : K3s dans une VM Multipass (macOS M3)
- **IaC** : Terraform avec providers kubernetes + helm
- **CI/CD** : GitHub Actions + ArgoCD (à venir)
- **Apps** : Finances, Tâches, Nextcloud, Monitoring (à venir)

## Phases
- [x] Phase 1 — K3s local avec Multipass
- [x] Phase 2 — Objets Kubernetes de base (Pod, Deployment, Service, Ingress)
- [ ] Phase 3 — Terraform (en cours)
- [ ] Phase 4 — CI/CD GitOps (GitHub Actions + ArgoCD)
- [ ] Phase 5 — Apps colocation
- [ ] Phase 6 — Observabilité (Prometheus + Grafana)

## Lancer le cluster
```bash
multipass start k3s-node
export KUBECONFIG=~/.kube/k3s-config
```

## Terraform
```bash
cd infrastructure/terraform
terraform init
terraform apply
```
