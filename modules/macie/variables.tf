variable "account_finding_publishing_frequency" {
  default = "SIX_HOURS"
  validation {
    condition     = contains(["FIFTEEN_MINUTES", "ONE_HOUR", "SIX_HOURS"], var.account_finding_publishing_frequency)
    error_message = "Invalid value for account_finding_publishing_frequency"
  }
}

variable "status" {
  default = "ENABLED"
  validation {
    condition     = contains(["ENABLED", "PAUSED"], var.status)
    error_message = "Invalid value for status"
  }
}

variable "s3_access_logging_bucket_name" {
  description = "The name of the bucket that will receive the log objects"
  type        = string
}

variable "account_name" {
  description = "Account Name"
  type        = string
}

variable "product" {
  description = "Product/Service name"
  type        = string
}
