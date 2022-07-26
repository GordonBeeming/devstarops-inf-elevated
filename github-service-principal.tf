resource "azuread_application" "github-repo-local-edge" {
  display_name = "GitHub Repo (local-edge)"
}

resource "azuread_service_principal" "github-repo-local-edge" {
  application_id = azuread_application.github-repo-local-edge.application_id
}

resource "azuread_application_federated_identity_credential" "github-repo-local-edge" {
  application_object_id = azuread_application.github-repo-local-edge.object_id
  display_name          = "devstarops-local-edge"
  description           = "Deployments for devstarops-edge"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:DevStarOps/devstarops-edge"
}