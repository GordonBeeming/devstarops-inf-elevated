# data "github_actions_public_key" "devstarops-edge" {
#   repository = "devstarops-edge"
# }

data "github_user" "current" {
  username = "devstarops"
}

data "github_repository" "devstarops-edge" {
  full_name = "DevStarOps/devstarops-edge"
}

resource "github_repository_environment" "local" {
  environment  = "local"
  repository   = data.github_repository.devstarops-edge.id
}

resource "github_repository_environment" "test" {
  environment  = "test"
  repository   = data.github_repository.devstarops-edge.id
}

resource "github_repository_environment" "production" {
  environment  = "production"
  repository   = data.github_repository.devstarops-edge.id
  reviewers {
    users = [data.github_user.current.id]
  }
  
}

# AZURE_CLIENT_ID
resource "github_actions_environment_secret" "local_AZURE_CLIENT_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.local.environment
  secret_name      = "AZURE_CLIENT_ID"
  plaintext_value  = azuread_application.eco-local.application_id
}
resource "github_actions_environment_secret" "test_AZURE_CLIENT_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.test.environment
  secret_name      = "AZURE_CLIENT_ID"
  plaintext_value  = azuread_application.eco-test.application_id
}
resource "github_actions_environment_secret" "production_AZURE_CLIENT_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.production.environment
  secret_name      = "AZURE_CLIENT_ID"
  plaintext_value  = azuread_application.eco-production.application_id
}

# AZURE_TENANT_ID
resource "github_actions_environment_secret" "local_AZURE_TENANT_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.local.environment
  secret_name      = "AZURE_TENANT_ID"
  plaintext_value  = data.azurerm_client_config.current.tenant_id
}
resource "github_actions_environment_secret" "test_AZURE_TENANT_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.test.environment
  secret_name      = "AZURE_TENANT_ID"
  plaintext_value  = data.azurerm_client_config.current.tenant_id
}
resource "github_actions_environment_secret" "production_AZURE_TENANT_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.production.environment
  secret_name      = "AZURE_TENANT_ID"
  plaintext_value  = data.azurerm_client_config.current.tenant_id
}

# AZURE_SUBSCRIPTION_ID
resource "github_actions_environment_secret" "local_AZURE_SUBSCRIPTION_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.local.environment
  secret_name      = "AZURE_SUBSCRIPTION_ID"
  plaintext_value  = data.azurerm_client_config.current.subscription_id
}
resource "github_actions_environment_secret" "test_AZURE_SUBSCRIPTION_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.test.environment
  secret_name      = "AZURE_SUBSCRIPTION_ID"
  plaintext_value  = data.azurerm_client_config.current.subscription_id
}
resource "github_actions_environment_secret" "production_AZURE_SUBSCRIPTION_ID" {
  repository       = data.github_repository.devstarops-edge.id
  environment      = github_repository_environment.production.environment
  secret_name      = "AZURE_SUBSCRIPTION_ID"
  plaintext_value  = data.azurerm_client_config.current.subscription_id
}
