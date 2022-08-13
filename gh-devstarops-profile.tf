
data "github_repository" "devstarops-profile" {
  full_name = "DevStarOps/devstarops-profile"
}

resource "github_repository_environment" "local-profile" {
  environment  = "local"
  repository   = data.github_repository.devstarops-profile.id
}

resource "azuread_application_federated_identity_credential" "eco-local-profile" {
  application_object_id = azuread_application.eco-local.object_id
  display_name          = "devstarops-profile"
  description           = "Deployments for devstarops-profile"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:DevStarOps/devstarops-profile:environment:local"
}

resource "github_repository_environment" "test-profile" {
  environment  = "test"
  repository   = data.github_repository.devstarops-profile.id
}

resource "azuread_application_federated_identity_credential" "eco-test-profile" {
  application_object_id = azuread_application.eco-test.object_id
  display_name          = "devstarops-profile"
  description           = "Deployments for devstarops-profile"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:DevStarOps/devstarops-profile:environment:test"
}

resource "github_repository_environment" "production-profile" {
  environment  = "production"
  repository   = data.github_repository.devstarops-profile.id
  reviewers {
    users = [data.github_user.current.id]
  }  
}

resource "azuread_application_federated_identity_credential" "eco-production-profile" {
  application_object_id = azuread_application.eco-production.object_id  
  display_name          = "devstarops-profile"
  description           = "Deployments for devstarops-profile"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:DevStarOps/devstarops-profile:environment:production"
}

# ARM_CLIENT_ID
resource "github_actions_environment_secret" "local-profile-ARM_CLIENT_ID" {
  repository       = data.github_repository.devstarops-profile.id
  environment      = github_repository_environment.local-profile.environment
  secret_name      = "ARM_CLIENT_ID"
  plaintext_value  = azuread_application.eco-local.application_id
}
resource "github_actions_environment_secret" "test-profile-ARM_CLIENT_ID" {
  repository       = data.github_repository.devstarops-profile.id
  environment      = github_repository_environment.test-profile.environment
  secret_name      = "ARM_CLIENT_ID"
  plaintext_value  = azuread_application.eco-test.application_id
}
resource "github_actions_environment_secret" "production-profile-ARM_CLIENT_ID" {
  repository       = data.github_repository.devstarops-profile.id
  environment      = github_repository_environment.production-profile.environment
  secret_name      = "ARM_CLIENT_ID"
  plaintext_value  = azuread_application.eco-production.application_id
}

# ARM_TENANT_ID
resource "github_actions_environment_secret" "local-profile-ARM_TENANT_ID" {
  repository       = data.github_repository.devstarops-profile.id
  environment      = github_repository_environment.local-profile.environment
  secret_name      = "ARM_TENANT_ID"
  plaintext_value  = data.azurerm_client_config.current.tenant_id
}
resource "github_actions_environment_secret" "test-profile-ARM_TENANT_ID" {
  repository       = data.github_repository.devstarops-profile.id
  environment      = github_repository_environment.test-profile.environment
  secret_name      = "ARM_TENANT_ID"
  plaintext_value  = data.azurerm_client_config.current.tenant_id
}
resource "github_actions_environment_secret" "production-profile-ARM_TENANT_ID" {
  repository       = data.github_repository.devstarops-profile.id
  environment      = github_repository_environment.production-profile.environment
  secret_name      = "ARM_TENANT_ID"
  plaintext_value  = data.azurerm_client_config.current.tenant_id
}

# ARM_SUBSCRIPTION_ID
resource "github_actions_environment_secret" "local-profile-ARM_SUBSCRIPTION_ID" {
  repository       = data.github_repository.devstarops-profile.id
  environment      = github_repository_environment.local-profile.environment
  secret_name      = "ARM_SUBSCRIPTION_ID"
  plaintext_value  = data.azurerm_client_config.current.subscription_id
}
resource "github_actions_environment_secret" "test-profile-ARM_SUBSCRIPTION_ID" {
  repository       = data.github_repository.devstarops-profile.id
  environment      = github_repository_environment.test-profile.environment
  secret_name      = "ARM_SUBSCRIPTION_ID"
  plaintext_value  = data.azurerm_client_config.current.subscription_id
}
resource "github_actions_environment_secret" "production-profile-ARM_SUBSCRIPTION_ID" {
  repository       = data.github_repository.devstarops-profile.id
  environment      = github_repository_environment.production-profile.environment
  secret_name      = "ARM_SUBSCRIPTION_ID"
  plaintext_value  = data.azurerm_client_config.current.subscription_id
}
