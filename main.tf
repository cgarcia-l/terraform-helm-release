resource "helm_release" "this" {
  for_each = var.apps

  namespace            = try(each.value["namespace"], null)
  repository           = try(each.value["repository"], null)
  name                 = try(each.value["name"], null)
  chart                = try(each.value["chart"], null)
  version              = try(each.value["version"], null)
  repository_key_file  = try(each.value["repository_key_file"], null)
  repository_cert_file = try(each.value["repository_cert_file"], null)
  repository_ca_file   = try(each.value["repository_ca_file"], null)
  repository_username  = try(each.value["repository_username"], null)
  repository_password  = try(each.value["repository_password"], null)

  # Otras propiedades con valores predeterminados
  force_update               = try(each.value["force_update"], false)
  wait                       = try(each.value["wait"], true)
  recreate_pods              = try(each.value["recreate_pods"], true)
  max_history                = try(each.value["max_history"], 0)
  lint                       = try(each.value["lint"], true)
  cleanup_on_fail            = try(each.value["cleanup_on_fail"], false)
  create_namespace           = try(each.value["create_namespace"], false)
  disable_webhooks           = try(each.value["disable_webhooks"], false)
  verify                     = try(each.value["verify"], false)
  reuse_values               = try(each.value["reuse_values"], false)
  reset_values               = try(each.value["reset_values"], false)
  atomic                     = try(each.value["atomic"], false)
  skip_crds                  = try(each.value["skip_crds"], false)
  render_subchart_notes      = try(each.value["render_subchart_notes"], true)
  disable_openapi_validation = try(each.value["disable_openapi_validation"], false)
  wait_for_jobs              = try(each.value["wait_for_jobs"], false)
  dependency_update          = try(each.value["dependency_update"], false)
  replace                    = try(each.value["replace"], false)
  timeout                    = try(each.value["timeout"], null)
  values                     = try(each.value["values"], [])

  dynamic "set" {
    for_each = each.value.set == null ? [] : each.value.set
    content {
      name  = set.value.name
      value = set.value.value
    }
  }

  dynamic "set_sensitive" {
    for_each = each.value.set_sensitive == null ? [] : each.value.set_sensitive
    content {
      name  = set_sensitive.value.path
      value = set_sensitive.value.value
    }
  }
}
