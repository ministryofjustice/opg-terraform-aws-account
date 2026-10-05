variable "bucket_name" {
  description = "trail name"
  default     = "cloudtrail"
  type        = string
}

variable "trail_name" {
  description = "trail name"
  default     = "cloudtrail"
  type        = string
}

variable "vpc_endpoint_access_denied_logging_enabled" {
  description = "Create an additional trail that logs network activity events denied by a VPC endpoint policy to the existing CloudTrail log group."
  type        = bool
  default     = false
}

variable "s3_access_logging_bucket_name" {
  description = "The name of the bucket that will receive the log objects"
  type        = string
}

variable "sns_failure_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}

variable "sns_success_feedback_role_arn" {
  type        = string
  description = "The ARN of the IAM role that allows Amazon SNS to write logs about SMS deliveries in CloudWatch Logs."
}
