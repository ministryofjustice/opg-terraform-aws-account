variable "finding_publishing_frequency" {
  type = string
  validation {
    condition     = contains(["FIFTEEN_MINUTES", "ONE_HOUR", "SIX_HOURS"], var.finding_publishing_frequency)
    error_message = "Invalid value for finding_publishing_frequency"
  }
}

variable "status" {
  type = string
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

variable "macie_findings_s3_bucket_kms_key" {
  description = "The KMS key used to encrypt the Macie findings S3 bucket"
  type        = any
}
