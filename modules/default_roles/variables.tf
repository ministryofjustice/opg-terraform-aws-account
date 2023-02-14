variable "aws_cloudwatch_log_group_cloudtrail_name" {
  type        = string
  default     = null
  description = "Name of the trail."
}

variable "aws_cloudwatch_namespace_prefix" {
  type        = string
  default     = null
  description = "Prefix for the namespace."
}

variable "create_assume_alarm" {
  type        = bool
  default     = false
  description = "Create the assume role alarm."
}

variable "alarm_sns_topic_arn" {
  type        = string
  default     = null
  description = "SNS topic ARN to send the alarm to."
}

variable "user_arns" {
  type    = list(string)
  default = []
}

variable "account_name" {
  type        = string
  description = "Name of the account."
  default     = "development"
}

variable "name" {}

variable "base_policy_arn" {
  default = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

variable "custom_policy_json" {
  default = ""
}

variable "create_instance_profile" {
  type    = bool
  default = false
}