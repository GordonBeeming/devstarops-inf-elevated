
data "github_repository" "devstarops-edge" {
  full_name = "DevStarOps/devstarops-edge"
}

resource "github_repository_environment" "local-edge" {
  environment  = "local"
  repository   = data.github_repository.devstarops-edge.id
}

resource "github_repository_environment" "test-edge" {
  environment  = "test"
  repository   = data.github_repository.devstarops-edge.id
}

resource "github_repository_environment" "production-edge" {
  environment  = "production"
  repository   = data.github_repository.devstarops-edge.id
  reviewers {
    users = [data.github_user.current.id]
  }
  
}

# AZURE_CLIENT_ID
resource "github_actions_environment_secret" "local-edge-AZURE_CLIENT_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.local-edge.environment
  secret_name      = "AZURE_CLIENT_ID"
  plaintext_value  = azuread_application.eco-local.application_id
}
resource "github_actions_environment_secret" "test-edge-AZURE_CLIENT_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.test-edge.environment
  secret_name      = "AZURE_CLIENT_ID"
  plaintext_value  = azuread_application.eco-test.application_id
}
resource "github_actions_environment_secret" "production-edge-AZURE_CLIENT_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.production-edge.environment
  secret_name      = "AZURE_CLIENT_ID"
  plaintext_value  = azuread_application.eco-production.application_id
}

# AZURE_TENANT_ID
resource "github_actions_environment_secret" "local-edge-AZURE_TENANT_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.local-edge.environment
  secret_name      = "AZURE_TENANT_ID"
  plaintext_value  = data.azurerm_client_config.current.tenant_id
}
resource "github_actions_environment_secret" "test-edge-AZURE_TENANT_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.test-edge.environment
  secret_name      = "AZURE_TENANT_ID"
  plaintext_value  = data.azurerm_client_config.current.tenant_id
}
resource "github_actions_environment_secret" "production-edge-AZURE_TENANT_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.production-edge.environment
  secret_name      = "AZURE_TENANT_ID"
  plaintext_value  = data.azurerm_client_config.current.tenant_id
}

# AZURE_SUBSCRIPTION_ID
resource "github_actions_environment_secret" "local-edge-AZURE_SUBSCRIPTION_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.local-edge.environment
  secret_name      = "AZURE_SUBSCRIPTION_ID"
  plaintext_value  = data.azurerm_client_config.current.subscription_id
}
resource "github_actions_environment_secret" "test-edge-AZURE_SUBSCRIPTION_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.test-edge.environment
  secret_name      = "AZURE_SUBSCRIPTION_ID"
  plaintext_value  = data.azurerm_client_config.current.subscription_id
}
resource "github_actions_environment_secret" "production-edge-AZURE_SUBSCRIPTION_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.production-edge.environment
  secret_name      = "AZURE_SUBSCRIPTION_ID"
  plaintext_value  = data.azurerm_client_config.current.subscription_id
}
