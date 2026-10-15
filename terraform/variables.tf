variable "subscription_id" {
  type        = string
  description = "Value from tfvars"
}

variable "budget_amount" {
  type        = number
  default     = 50
  description = "Monthly budget threshold"
}

variable "budget_threshold_percent" {
  type        = number
  default     = 80
  description = "Example is alert at 80% of Monthly budget threshold"
}

variable "alert_email" {
  type        = string
  description = "Real email goes in tfvars"
}

variable "resource_group_name" {
  type        = string
  default     = "cost-visibility-rg"
  description = "Resource Group"
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Default region"
}

variable "sendgrid_api_key" {
  type        = string
  description = "SendGrid API key for sending cost alert emails"
  sensitive   = true
}