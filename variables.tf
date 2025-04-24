variable "account_name" {
  description = "Account Name"
  type        = string
}

variable "aws_config_enabled" {
  type    = bool
  default = false
}

variable "config_continuous_resource_recording" {
  description = "Should the configuration recorder scan constantly or daily (set to false in dev accounts)"
  type        = bool
  default     = true
}

variable "aws_security_hub_enabled" {
  type    = bool
  default = false
}

variable "aws_slack_notifications_enabled" {
  description = "Whether to enable alerting to slack. To be used with slack cost/health notification channel."
  type        = bool
  default     = false
}

variable "aws_slack_cost_anomaly_notification_channel" {
  description = "Slack's internal ID for the channel you want to post cost anomalies to. Format AB1C2DEF"
  type        = string
  default     = ""
}

variable "aws_slack_health_notification_channel" {
  description = "Slack's internal ID for the channel you want to post health alrets to. Format AB1C2DEF"
  type        = string
  default     = ""
}

variable "breakglass_base_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/AdministratorAccess"
}

variable "data_access_base_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

variable "breakglass_create_instance_profile" {
  type    = bool
  default = false
}

variable "breakglass_custom_policy_json" {
  type    = string
  default = ""
}

variable "data_access_custom_policy_json" {
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

variable "data_access_create_instance_profile" {
  type    = bool
  default = false
}

variable "product" {
  type = string
}

variable "viewer_base_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

variable "viewer_custom_policy_json" {
  type    = string
  default = ""
}

variable "onboarding_base_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

variable "onboarding_custom_policy_json" {
  type    = string
  default = ""
}

variable "has_onboarding" {
  type        = bool
  default     = false
  description = "Whether the account has an onboarding role (only for development accounts)"
}

variable "user_arns" {
  type = object({
    view        = list(string)
    operation   = list(string)
    breakglass  = list(string)
    data_access = list(string)
    onboarding  = list(string)
    ci          = list(string)
  })
}

variable "aws_s3_account_block_public_access_enable" {
  type        = bool
  default     = false
  description = "Whether Amazon S3 should enable public blocks for buckets in this account. Defaults to False."
}
variable "aws_s3_account_block_public_acls" {
  type        = bool
  default     = true
  description = "Whether Amazon S3 should block public ACLs for buckets in this account. Defaults to true."
}
variable "aws_s3_account_block_public_policy" {
  type        = bool
  default     = true
  description = "Whether Amazon S3 should block public bucket policies for buckets in this account. Defaults to true."
}
variable "aws_s3_account_ignore_public_acls" {
  type        = bool
  default     = true
  description = "Whether Amazon S3 should ignore public ACLs for buckets in this account. Defaults to true."
}
variable "aws_s3_account_restrict_public_buckets" {
  type        = bool
  default     = true
  description = "Whether Amazon S3 should restrict public bucket policies for buckets in this account. Defaults to true."
}

variable "cis_foundation_alarms_enabled" {
  type        = bool
  default     = true
  description = "Whether to create metrics alarms to support CIS Foundation compliance. Defaults to true."
}

variable "cis_metric_namespace" {
  type        = string
  default     = "CISLogMetrics"
  description = "The destination namespace of the CIS CloudWatch metric."
}

variable "cis_foundation_control_1_14_enabled" {
  type        = bool
  default     = false
  description = "When true, creates a metric filter and alarm for CIS.1.14. When false, sets standard control to disabled."
}

variable "cis_foundation_control_3_4_enabled" {
  type        = bool
  default     = true
  description = "When true, creates a metric filter and alarm for CIS.3.4. When false, sets standard control to disabled."
}
variable "cis_foundation_control_3_8_enabled" {
  type        = bool
  default     = true
  description = "When true, creates a metric filter and alarm for CIS.3.8. When false, sets standard control to disabled."
}
variable "cis_foundation_control_3_10_enabled" {
  type        = bool
  default     = true
  description = "When true, creates a metric filter and alarm for CIS.3.10. When false, sets standard control to disabled."
}
variable "cis_foundation_control_3_10_custom_filter" {
  type        = string
  default     = ""
  description = "When provided, creates a custom metric filter and alarm for CIS.3.10 and disables the control in security hub."
}
variable "cis_foundation_control_3_11_enabled" {
  type        = bool
  default     = true
  description = "When true, creates a metric filter and alarm for CIS.3.11. When false, sets standard control to disabled."
}
variable "cis_foundation_control_3_12_enabled" {
  type        = bool
  default     = true
  description = "When true, creates a metric filter and alarm for CIS.3.12. When false, sets standard control to disabled."
}
variable "cis_foundation_control_3_13_enabled" {
  type        = bool
  default     = true
  description = "When true, creates a metric filter and alarm for CIS.3.13. When false, sets standard control to disabled."
}

variable "cis_foundation_control_3_14_enabled" {
  type        = bool
  default     = true
  description = "When true, creates a metric filter and alarm for CIS.3.14. When false, sets standard control to disabled."
}

variable "fsbp_standard_control_elb_6_enabled" {
  type        = bool
  default     = true
  description = "When false, sets standard control to disabled."
}

variable "cost_anomaly_notification_email_address" {
  type        = string
  default     = null
  description = "Email address to use to send anomaly alerts to"
}

variable "cost_anomaly_weekly_schedule_threshold" {
  type        = string
  default     = "100.0"
  description = "The value that triggers a weekly notification if the threshold is exceeded. By default, an absolute dollar value, but changing `threshold_expression_type` changes this to percentage."
}

variable "cost_anomaly_immediate_schedule_threshold" {
  type        = string
  default     = "10.0"
  description = "The value that triggers an immediate notification if the threshold is exceeded. By default, an absolute dollar value, but changing `threshold_expression_type` changes this to percentage."
}

variable "cost_anomaly_threshold_expression_type" {
  type        = string
  default     = "ANOMALY_TOTAL_IMPACT_ABSOLUTE"
  description = "Setting passed to the threshold_expression to determine if the value (weekly_schedule_threshold|immediate_schedule_threshold) is an absolute (ANOMALY_TOTAL_IMPACT_ABSOLUTE) or percentage (ANOMALY_TOTAL_IMPACT_PERCENTAGE)"
}

variable "custom_alarms_breakglass_login_alarm_enabled" {
  default     = true
  description = "Enable or disable the breakglass login alarm"
  type        = bool
}

### security hub >= v4.60 additions

# added in v4.64.0 with a default of 'SECURITY_CONTROL' which breaks current config
variable "control_finding_generator" {
  type        = string
  default     = "STANDARD_CONTROL"
  description = "Updates whether the calling account has consolidated control findings turned on"
}

# added in v4.64.0 with a default of true
variable "auto_enable_controls" {
  type        = bool
  default     = true
  description = "Whether to automatically enable new controls when they are added to standards that are enabled"
}
# added in v4.60.0 with default of true, but we'll set to false
variable "enable_default_standards" {
  type        = bool
  default     = false
  description = "Whether to enable the security standards that Security Hub has designated as automatically enabled"
}

variable "modernisation_platform_account" {
  type        = bool
  default     = false
  description = "IF this is a vendored account from the Modernisation Platform"
}

variable "shield_support_role_enabled" {
  type        = bool
  default     = false
  description = "Whether to create the Shield Support Role to allow AWS security engineers to access the account to assist with DDoS mitigation"
}

variable "oam_xray_sink_identifier_arn" {
  type        = string
  default     = null
  description = "The identifier of the OAM Sink to duplicate XRay events to (if desired)"
}

# added to enable github oidc provider in the account
variable "github_oidc_enabled" {
  type        = bool
  default     = false
  description = "Enable an oidc provider in the account for use within github actions. Will create a stored query for the access log."
}


locals {
  aws_cost_anomaly_notifications_enabled = var.aws_slack_notifications_enabled && var.aws_slack_cost_anomaly_notification_channel != "" ? true : false
  aws_health_notifications_enabled       = var.aws_slack_notifications_enabled && var.aws_slack_health_notification_channel != "" ? true : false

  # Locals to control provisioning of Modernisation Platform Provisioned Services in new accounts.
  cloudtrail_enabled          = !var.modernisation_platform_account
  config_enabled              = var.aws_config_enabled && !var.modernisation_platform_account ? true : false
  guardduty_enabled           = var.enable_guardduty && !var.modernisation_platform_account ? true : false
  security_hub_enabled        = var.aws_security_hub_enabled && !var.modernisation_platform_account ? true : false
  shield_support_role_enabled = var.shield_support_role_enabled && !var.modernisation_platform_account ? true : false

}

variable "aws_iam_account_alias" {
  description = "The AWS IAM Account Alias to use for the account"
  type        = string
  validation {
    condition     = length(var.aws_iam_account_alias) > 0
    error_message = "The AWS IAM Account Alias must be set."
  }
  validation {
    condition     = can(regexall("^[a-zA-Z0-9-]+$", var.aws_iam_account_alias))
    error_message = "The AWS IAM Account Alias must only contain alphanumeric characters and hyphens."
  }
}

variable "aws_account_primary_contact" {
  description = "The primary contact for the account."
  type = object({
    address_line_1  = string
    address_line_2  = string
    city            = string
    company_name    = string
    country_code    = string
    phone_number    = string
    postal_code     = string
    state_or_region = string
    full_name       = string
  })
}

variable "aws_account_alternate_contact" {
  description = "The alternate contacts for the account."
  type = object({
    operations = object({
      name          = string
      title         = string
      email_address = string
      phone_number  = string
    })
    security = object({
      name          = string
      title         = string
      email_address = string
      phone_number  = string
    })
  })
}

variable "pagerduty_securityhub_integration_key" {
  type        = string
  default     = null
  description = "The PagerDuty integration key to subscribe to SecurityHub findings"
  sensitive   = true
}

variable "aws_macie2_finding_publishing_frequency" {
  type    = string
  default = "SIX_HOURS"
  validation {
    condition     = contains(["FIFTEEN_MINUTES", "ONE_HOUR", "SIX_HOURS"], var.aws_macie2_finding_publishing_frequency)
    error_message = "Invalid value for aws_macie2_finding_publishing_frequency"
  }
}

variable "aws_macie2_status" {
  type = string
  validation {
    condition     = contains(["ENABLED", "PAUSED"], var.aws_macie2_status)
    error_message = "Invalid value for aws_macie2_status"
  }
}
