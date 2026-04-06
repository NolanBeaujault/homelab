variable "kubeconfig_path" {
  description = "Chemin vers le fichier kubeconfig pour accéder au cluster"
  type        = string
  default     = "~/.kube/k3s-config"
}

variable "namespace" {
  description = "Namespace Kubernetes cible"
  type        = string
  default     = "homelab"
}
