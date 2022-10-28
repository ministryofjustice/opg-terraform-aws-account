variable "s3_bucket_event_types" {
  description = "The type of event that triggers the notification"
  type        = list(string)
  default     = ["s3:ObjectRemoved:*"]
}

variable "s3_bucket_id" {
  description = "The ID of the S3 bucket to which the notification is attached"
  type        = string
}

variable "sns_failure_feedback_role_arn" {
  description = "The ARN of the IAM role that Amazon SNS can assume when it needs to access your AWS resources to process your failure feedback"
  type        = string
}

variable "sns_success_feedback_role_arn" {
  description = "The ARN of the IAM role that Amazon SNS can assume when it needs to access your AWS resources to process your success feedback"
  type        = string
}

variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK"
  type        = string
}
