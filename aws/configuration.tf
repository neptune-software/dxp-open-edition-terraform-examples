locals {
  region = "eu-west-2"

  vpc = {
    cidr_block = "10.0.0.0/16"
    subnets = {
      "subnet1" = {
        cidr_block = "10.0.1.0/24"
      }
      "subnet2" = {
        cidr_block = "10.0.2.0/24"
      }
    }
  }

  eks = {
    name = "MyCluster"
  }

  kubectl_manifests = {
    planet9_namespace = {
      yaml_body = templatefile("${path.module}/templates/namespace.yaml.tpl", {
        name = "planet9"
      })
    }
    planet9_deployment = {
      yaml_body = templatefile("${path.module}/templates/deployment.yaml.tpl", {
        namespace = "planet9"
        name      = "planet9"
        replicas  = 1
        app       = "planet9"
        container = {
          name   = "planet9"
          image  = "neptunesoftware/planet9:latest"
          cpu    = "2000m"
          memory = "4Gi"
          port = {
            number = 8080
            name   = "planet9"
          }
        }
      })
    }
    planet9_service = {
      yaml_body = templatefile("${path.module}/templates/service.yaml.tpl", {
        namespace = "planet9"
        name      = "planet9"
        port      = 8080
        app       = "planet9"
        type      = "LoadBalancer"
      })
    }
  }
}
