## Provider Configuration
provider "aws" {
  region = "eu-west-1"
}

## Helm Release Module
module "example" {
  source = "../../"

  apps = {
    app1 = {
      namespace  = "argocd"
      name       = "argocd"
      repository = "https://argoproj.github.io/argo-helm"
      chart      = "argo-cd"
      version    = "v6.7.14"
    },
    app2 = {
      namespace            = "jenkins"
      name                 = "jenkins"
      repository           = "https://jenkins_url"
      chart                = "jenkins"
      version              = "v6.7.14"
      repository_key_file  = "path/to/keyfile"
      repository_cert_file = "path/to/certfile"
      repository_ca_file   = "path/to/cafile"
      repository_username  = "username"
      repository_password  = "password"
      set = [
        {
          name  = "key1"
          value = "value1"
        },
        {
          name  = "key2"
          value = "value2"
        }
      ]
      set_sensitive = [
        {
          path  = "secret1"
          value = "sensitive_value1"
        }
      ]
    }
  }
}

## Outputs

output "deployment" {
  value       = module.example.deployment
  description = "The state of the helm deployment"
}
