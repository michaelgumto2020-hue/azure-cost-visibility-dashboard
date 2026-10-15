resource "azurerm_monitor_action_group" "cost-altert-action-group" {
  name                = "cost-alert-action-group"
  resource_group_name = azurerm_resource_group.cost-visibility-rg.name
  short_name          = "costalert"
  webhook_receiver {
    name        = "logic-app-webhook"
    service_uri = azurerm_logic_app_trigger_custom.http_trigger.callback_url
  }
}