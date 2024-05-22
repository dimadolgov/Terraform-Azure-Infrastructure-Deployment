# Fetch admin password from Azure Key Vault
data "azurerm_key_vault_secret" "adminpassword" {
  name         = "adminpassword"
  key_vault_id = "/subscriptions/XXXXXXsubscriptions_IDXXXXXX/resourceGroups/KeyVault/providers/Microsoft.KeyVault/vaults/XXXXXXXXXXXXXXXXXX"
}