output "integration_test_app_registration_id" {
  description = "The id of the app registration for the integration tests"
  value       = azuread_application.integration_test_application.id
}