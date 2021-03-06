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

variable "s3_access_logging_bucket_name" {
  description = "The name of the bucket that will receive the log objects"
  type        = string
}
