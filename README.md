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
| apps | Map of applications to deploy | `map(any)` | n/a | yes |
| repository\_config | repository configuration | `map(any)` | `{}` | no |
| set | Value block with custom STRING values to be merged with the values yaml. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `null` | no |
| set\_sensitive | Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff. | <pre>list(object({<br>    path  = string<br>    value = string<br>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| deployment | The state of the helm deployment |

## Requirements

No requirements.

## Examples

```hcl
terraform {
  required_version = "~> 1.5.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

# Modules implementation
module "example" {
  source = "../../"

  apps = {
    app1 = {
      namespace         = "argocd"
      name              = "argocd"
      repository        = "https://argoproj.github.io/argo-helm"
      chart             = "argo-cd"
      version           = "v6.7.14"
      set               = []
      set_sensitive     = []
      repository_config = {}
    },
    app2 = {
      namespace  = "jenkins"
      name       = "jenkins"
      repository = "https://jenkins_url"
      chart      = "jenkins"
      version    = "v6.7.14"
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
      repository_config = {
        repository_key_file  = "path/to/keyfile"
        repository_cert_file = "path/to/certfile"
        repository_ca_file   = "path/to/cafile"
        repository_username  = "username"
        repository_password  = "password"
      }
    }
  }
}

# Outputs
output "deployment" {
  value       = module.example.deployment
  description = "The state of the helm deployment"
}
```

[//]: # (END_TF_DOCS)
