variable "account_name" {
  default     = ""
  description = "Account Name"
  type        = string
}

variable "baseline_security_enabled" {
  type    = bool
  default = false
}

variable "breakglass_base_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "breakglass_create_instance_profile" {
  type    = bool
  default = false
}

variable "breakglass_custom_policy_json" {
  type    = string
  default = ""
}

variable "billing_base_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/job-function/Billing"
}

variable "billing_custom_policy_json" {
  type    = string
  default = ""
}

variable "ci_base_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "ci_custom_policy_json" {
  type    = string
  default = ""
}

variable "cloudtrail_bucket_name" {
  description = "trail name"
  default     = "cloudtrail"
  type        = string
}

variable "cloudtrail_trail_name" {
  description = "trail name"
  default     = "cloudtrail"
  type        = string
}

variable "enable_guardduty" {
  type    = bool
  default = true
}

variable "is_production" {
  type    = bool
  default = false
}

variable "operator_base_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

variable "operator_custom_policy_json" {
  type    = string
  default = ""
}

variable "operator_create_instance_profile" {
  type    = bool
  default = false
}

variable "product" {
  type = string
}

variable "team_name" {
  default     = "OPG"
  description = "Name of the Team looking after the Service"
  type        = string
}

variable "team_email" {
  default     = "opgteam@digital.justice.gov.uk"
  description = "Team group email address for use in tags"
  type        = string
}

variable "viewer_base_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

variable "viewer_custom_policy_json" {
  type    = string
  default = ""
}

variable "user_arns" {
  type = object({
    view       = list(string)
    operation  = list(string)
    breakglass = list(string)
    ci         = list(string)
    billing    = list(string)
  })
}

locals {
  mandatory_moj_tags = {
    application      = var.product
    business-unit    = "OPG"
    environment-name = var.account_name
    is-production    = var.is_production
    owner            = "${var.team_name}: ${var.team_email}"
  }
}

variable "aws_s3_account_block_public_access_enable" {
  default     = false
  description = "Whether Amazon S3 should block public blocks for buckets in this account. Defaults to False."
}
variable "aws_s3_account_block_public_acls" {
  default     = true
  description = "Whether Amazon S3 should block public ACLs for buckets in this account. Defaults to true."
}
variable "aws_s3_account_block_public_policy" {
  default     = true
  description = "Whether Amazon S3 should block public bucket policies for buckets in this account. Defaults to true."
}
variable "aws_s3_account_ignore_public_acls" {
  default     = true
  description = "Whether Amazon S3 should ignore public ACLs for buckets in this account. Defaults to true."
}
variable "aws_s3_account_restrict_public_buckets" {
  default     = true
  description = "Whether Amazon S3 should restrict public bucket policies for buckets in this account. Defaults to true."
}
