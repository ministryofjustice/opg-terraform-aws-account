variable "account_name" {
  default     = ""
  description = "Account Name"
  type        = string
}

variable "config_delivery_frequency" {
  description = "The frequency with which AWS Config delivers configuration snapshots."
  default     = "Six_Hours"
  type        = string
}

variable "config_max_execution_frequency" {
  description = "The maximum frequency with which AWS Config runs evaluations for a rule."
  type        = string
  default     = "TwentyFour_Hours"
}

variable "product" {
  default     = ""
  description = "Product/Service name"
  type        = string
}

locals {
  config_name = "aws-config-${var.product}-${var.account_name}"
}
