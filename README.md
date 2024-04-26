# terraform-helm-release

Terraform module to deploy Helm charts using the Helm provider.

[//]: # (BEGIN_TF_DOCS)

## Providers

| Name | Version |
|------|---------|
| helm | 2.13.1 |

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| apps | Map of applications to deploy | <pre>map(object({<br>    namespace                  = string<br>    repository                 = string<br>    name                       = string<br>    chart                      = string<br>    version                    = string<br>    repository_key_file        = optional(string)<br>    repository_cert_file       = optional(string)<br>    repository_ca_file         = optional(string)<br>    repository_username        = optional(string)<br>    repository_password        = optional(string)<br>    force_update               = optional(bool)<br>    wait                       = optional(bool)<br>    recreate_pods              = optional(bool)<br>    max_history                = optional(number)<br>    lint                       = optional(bool)<br>    cleanup_on_fail            = optional(bool)<br>    create_namespace           = optional(bool)<br>    disable_webhooks           = optional(bool)<br>    verify                     = optional(bool)<br>    reuse_values               = optional(bool)<br>    reset_values               = optional(bool)<br>    atomic                     = optional(bool)<br>    skip_crds                  = optional(bool)<br>    render_subchart_notes      = optional(bool)<br>    disable_openapi_validation = optional(bool)<br>    wait_for_jobs              = optional(bool)<br>    dependency_update          = optional(bool)<br>    replace                    = optional(bool)<br>    timeout                    = optional(string)<br>    values                     = optional(list(string))<br>    set = optional(list(object({<br>      name  = string<br>      value = string<br>    })))<br>    set_sensitive = optional(list(object({<br>      path  = string<br>      value = string<br>    })))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| deployment | The state of the helm deployment |

## Requirements

No requirements.

## Examples

```hcl
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
```

[//]: # (END_TF_DOCS)

## How to Contribute

Submit a pull request

# Authors

Currently maintained by [Carlos García](https://github.com/cgarcia-l)