
data "azurerm_resource_group" "cems-rs-group" {
  name = "cems-rs-group"
}
data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

#User ID Creation
resource "azuread_user" "cems-users" {
  user_principal_name = "sankar.juvva3@gmail.com"
  display_name        = "Sankar Juvva"
  password            = "Test@12345"
  force_password_change = true
  mail_nickname       = "Sankar"
}
#Group ID Creation
resource "azuread_group" "cems-groups" {
  display_name     = "cems-savings"
  security_enabled = true
  mail_enabled     = false
  mail_nickname    = "developersgroup"
}
#azuread member adding
resource "azuread_group_member" "cems-grp-usr-add" {
  group_object_id  = azuread_group.cems-groups.id
  member_object_id = azuread_user.cems-users.id
}

#azuread app registration
resource "azuread_application" "cems-app" {
  display_name = "cems-app"
  sign_in_audience = "AzureADMyOrg"  # Single tenant, use "AzureADMultipleOrgs" for multi-tenant
}
# Create the Client Secret (Password Credential)
resource "azuread_application_password" "cems-client-secret" {
  application_id = azuread_application.cems-app.id
  display_name          = "terraform-secret"
}


#azuread service principle adding
resource "azuread_service_principal" "cems-sp" {
  client_id  = azuread_application.cems-app.client_id
}

# adding service principle role as a contributor role to subscrition 
resource "azurerm_role_assignment" "sp_contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.cems-sp.id
}