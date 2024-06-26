# terraform-helm-release

![](https://img.shields.io/github/v/tag/cgarcia-l/terraform-helm-release)
[![](https://img.shields.io/badge/semantic--release-conventionalcommits-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)
![](https://img.shields.io/github/issues/cgarcia-l/terraform-helm-release)
![](https://img.shields.io/github/issues-closed/cgarcia-l/terraform-helm-release)
[![](https://img.shields.io/github/languages/code-size/cgarcia-l/terraform-helm-release)](https://github.com/cgarcia-l/terraform-helm-release)
[![](https://img.shields.io/github/repo-size/cgarcia-l/terraform-helm-release)](https://github.com/cgarcia-l/terraform-helm-release)
![](https://img.shields.io/github/languages/top/cgarcia-l/terraform-helm-release?color=green&logo=terraform&logoColor=blue)
![](https://img.shields.io/github/commit-activity/m/cgarcia-l/terraform-helm-release)
![](https://img.shields.io/github/contributors/cgarcia-l/terraform-helm-release)
![](https://img.shields.io/github/last-commit/cgarcia-l/terraform-helm-release)
[![](https://img.shields.io/github/license/cgarcia-l/terraform-helm-release)](https://github.com/cgarcia-l/terraform-helm-release)

## Table of Contents
- [Description](#description)
- [Providers](#providers)
- [Resources](#resources)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [Requirements](#requirements)
- [Examples](#examples)
- [How to Contribute](#how-to-contribute)
- [Authors](#authors)
- [License](#license)

## Description

This repository contains a Terraform module for deploying Helm charts using the Helm provider. It's designed to be flexible and easy to use, allowing you to deploy a variety of applications with a single module. The module takes a map of applications as input, each with its own set of configuration options.

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
      repository           = "https://charts.jenkins.io"
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

# License

Apache 2.0 Licensed. See [LICENSE](./LICENSE) for full details.