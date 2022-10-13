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

variable "config_iam_role" {
  description = "Iam role object for the config role."
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
  config_name = "${var.product}-${var.account_name}"
}

variable "s3_access_logging_bucket_name" {
  description = "The name of the bucket that will receive the log objects"
  type        = string
}
