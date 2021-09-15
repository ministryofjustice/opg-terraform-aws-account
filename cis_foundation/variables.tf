variable "cis_metric_namespace" {
  type        = string
  description = "The destination namespace of the CIS CloudWatch metric."
}

variable "account_name" {
  type = string
}

variable "aws_cloudwatch_log_group_cloudtrail_name" {
  type        = string
  description = "Name of the trail."
}

variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
}
variable "controls_enabled" {
  type = object({
    root_account_usage   = bool
    root_account_usage_2 = bool
    root_account_usage_3 = bool
  })
}
