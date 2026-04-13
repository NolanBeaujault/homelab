provider "kubernetes" {
  config_path = var.kubeconfig_path
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_deployment" "app_deployment" {
  metadata {
    name      = "my-app-deployment"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "homelab-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "homelab-app"
        }
      }
      spec {
        container {
          name  = "my-app-container"
          image = "nginx:1.25"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "cluster_ip_service" {
  metadata {
    name      = "my-app-service"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "homelab-app"
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_ingress_v1" "app_ingress" {
  metadata {
    name      = "my-app-ingress"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
    annotations = {
      "traefik.ingress.kubernetes.io/router.entrypoints" = "web"
    }
  }

  spec {
    rule {
      host = "nginx.homelab"

      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.cluster_ip_service.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

