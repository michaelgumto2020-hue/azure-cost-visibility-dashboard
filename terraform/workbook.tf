resource "random_uuid" "workbook_id" {}

resource "azurerm_application_insights_workbook" "workbook" {
  name = random_uuid.workbook_id.result
  resource_group_name = azurerm_resource_group.cost-visibility-rg.name
  location = azurerm_resource_group.cost-visibility-rg.location
  display_name = "Cost Visibility Dashboard"
  data_json = file("${path.module}/../workbook/workbook-content.json")
  category = "workbook"
}