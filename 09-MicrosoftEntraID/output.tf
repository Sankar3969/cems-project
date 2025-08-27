output "client_id" {
  value = azuread_application.cems-app.client_id
}

output "client_secret" {
  value     = azuread_application_password.cems-client-secret.value
  sensitive = true
}