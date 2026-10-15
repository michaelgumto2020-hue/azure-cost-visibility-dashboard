resource "azurerm_consumption_budget_subscription" "monthly-cost-budget" {
  name            = "monthly-cost-budget"
  subscription_id = "/subscriptions/${var.subscription_id}"
  amount          = var.budget_amount
  time_grain      = "Monthly"
  time_period {
    start_date = "2026-10-01T00:00:00Z"
  }
  notification {
    enabled        = true
    threshold      = var.budget_threshold_percent
    operator       = "GreaterThan"
    contact_groups = [azurerm_monitor_action_group.cost-altert-action-group.id]
  }
}