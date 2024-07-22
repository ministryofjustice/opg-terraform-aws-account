
variable "s3_access_logging_bucket_names" {
  type        = list(string)
  description = "Log group to query for AssumeRoleWithWebIdentity actions"
  default     = []
}
