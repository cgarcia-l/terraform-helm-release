output "deployment" {
  value       = try(helm_release.this[*].metadata, null)
  description = "The state of the helm deployment"
}
