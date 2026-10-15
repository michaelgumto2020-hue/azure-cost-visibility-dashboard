resource "azurerm_resource_group" "cost-visibility-rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_logic_app_workflow" "cost-alert-logic-app" {
  name                = "cost-alert-logic-app"
  location            = azurerm_resource_group.cost-visibility-rg.location
  resource_group_name = azurerm_resource_group.cost-visibility-rg.name
}

resource "azurerm_logic_app_trigger_custom" "http_trigger" {
  name         = "manual"
  logic_app_id = azurerm_logic_app_workflow.cost-alert-logic-app.id
  body = jsonencode({
    type = "Request"
    kind = "Http"
    inputs = {
      schema = {}
    }
  })
}

resource "azurerm_logic_app_action_custom" "http_post" {
  name         = "send_email"
  logic_app_id = azurerm_logic_app_workflow.cost-alert-logic-app.id
  body = jsonencode({
    type = "Http"
    inputs = {
      method = "POST"
      uri    = "https://api.sendgrid.com/v3/mail/send"
      headers = {
        "Authorization" = "Bearer ${var.sendgrid_api_key}"
        "Content-Type"  = "application/json"
      }
      body = {
        personalizations = [
          {
            to = [
              { email = var.alert_email }
            ]
          }
        ]
        from    = { email = var.alert_email }
        subject = "Cost Alert Triggered"
        content = [
          {
            type  = "text/plain"
            value = "Your Azure budget threshold has been exceeded."
          }
        ]
      }
    }
  })
}