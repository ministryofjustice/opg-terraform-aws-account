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

variable "tags" {
  type        = map(any)
  description = "Tags to apply to all taggable resources"
}
