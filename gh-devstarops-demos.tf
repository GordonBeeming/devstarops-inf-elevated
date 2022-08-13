
data "github_repository" "devstarops-demos" {
  full_name = "DevStarOps/devstarops-demos"
}

resource "github_repository_environment" "local-demos" {
  environment  = "local"
  repository   = data.github_repository.devstarops-demos.id
}

resource "azuread_application_federated_identity_credential" "eco-local-demos" {
  application_object_id = azuread_application.eco-local.object_id
  display_name          = "devstarops-demos"
  description           = "Deployments for devstarops-demos"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:DevStarOps/devstarops-demos:environment:local"
}

resource "github_repository_environment" "test-demos" {
  environment  = "test"
  repository   = data.github_repository.devstarops-demos.id
}

resource "azuread_application_federated_identity_credential" "eco-test-demos" {
  application_object_id = azuread_application.eco-test.object_id
  display_name          = "devstarops-demos"
  description           = "Deployments for devstarops-demos"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:DevStarOps/devstarops-demos:environment:test"
}

resource "github_repository_environment" "production-demos" {
  environment  = "production"
  repository   = data.github_repository.devstarops-demos.id
  reviewers {
    users = [data.github_user.current.id]
  }  
}

resource "github_branch_protection" "devstarops-demos-main" {
  repository_id = data.github_repository.devstarops-demos.id
  pattern          = "main"
  enforce_admins   = true
  require_signed_commits = true
}

resource "azuread_application_federated_identity_credential" "eco-production-demos" {
  application_object_id = azuread_application.eco-production.object_id  
  display_name          = "devstarops-demos"
  description           = "Deployments for devstarops-demos"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:DevStarOps/devstarops-demos:environment:production"
}

## Secrets

# ARM_CLIENT_ID
resource "github_actions_environment_secret" "local-demos-ARM_CLIENT_ID" {
  repository       = data.github_repository.devstarops-demos.id
  environment      = github_repository_environment.local-demos.environment
  secret_name      = "ARM_CLIENT_ID"
  plaintext_value  = azuread_application.eco-local.application_id
}
resource "github_actions_environment_secret" "test-demos-ARM_CLIENT_ID" {
  repository       = data.github_repository.devstarops-demos.id
  environment      = github_repository_environment.test-demos.environment
  secret_name      = "ARM_CLIENT_ID"
  plaintext_value  = azuread_application.eco-test.application_id
}
resource "github_actions_environment_secret" "production-demos-ARM_CLIENT_ID" {
  repository       = data.github_repository.devstarops-demos.id
  environment      = github_repository_environment.production-demos.environment
  secret_name      = "ARM_CLIENT_ID"
  plaintext_value  = azuread_application.eco-production.application_id
}

# ARM_TENANT_ID
resource "github_actions_environment_secret" "local-demos-ARM_TENANT_ID" {
  repository       = data.github_repository.devstarops-demos.id
  environment      = github_repository_environment.local-demos.environment
  secret_name      = "ARM_TENANT_ID"
  plaintext_value  = data.azurerm_client_config.current.tenant_id
}
resource "github_actions_environment_secret" "test-demos-ARM_TENANT_ID" {
  repository       = data.github_repository.devstarops-demos.id
  environment      = github_repository_environment.test-demos.environment
  secret_name      = "ARM_TENANT_ID"
  plaintext_value  = data.azurerm_client_config.current.tenant_id
}
resource "github_actions_environment_secret" "production-demos-ARM_TENANT_ID" {
  repository       = data.github_repository.devstarops-demos.id
  environment      = github_repository_environment.production-demos.environment
  secret_name      = "ARM_TENANT_ID"
  plaintext_value  = data.azurerm_client_config.current.tenant_id
}

# ARM_SUBSCRIPTION_ID
resource "github_actions_environment_secret" "local-demos-ARM_SUBSCRIPTION_ID" {
  repository       = data.github_repository.devstarops-demos.id
  environment      = github_repository_environment.local-demos.environment
  secret_name      = "ARM_SUBSCRIPTION_ID"
  plaintext_value  = data.azurerm_client_config.current.subscription_id
}
resource "github_actions_environment_secret" "test-demos-ARM_SUBSCRIPTION_ID" {
  repository       = data.github_repository.devstarops-demos.id
  environment      = github_repository_environment.test-demos.environment
  secret_name      = "ARM_SUBSCRIPTION_ID"
  plaintext_value  = data.azurerm_client_config.current.subscription_id
}
resource "github_actions_environment_secret" "production-demos-ARM_SUBSCRIPTION_ID" {
  repository       = data.github_repository.devstarops-demos.id
  environment      = github_repository_environment.production-demos.environment
  secret_name      = "ARM_SUBSCRIPTION_ID"
  plaintext_value  = data.azurerm_client_config.current.subscription_id
}
