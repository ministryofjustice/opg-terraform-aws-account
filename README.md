## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.38 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |
| <a name="provider_aws.eu-west-2"></a> [aws.eu-west-2](#provider\_aws.eu-west-2) | 5.100.0 |
| <a name="provider_aws.global"></a> [aws.global](#provider\_aws.global) | 5.100.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_breakglass"></a> [breakglass](#module\_breakglass) | ./modules/default_roles | n/a |
| <a name="module_ci"></a> [ci](#module\_ci) | ./modules/default_roles | n/a |
| <a name="module_cloudtrail"></a> [cloudtrail](#module\_cloudtrail) | ./modules/cloudtrail | n/a |
| <a name="module_cloudwatch_loginsights_cis_queries_opg"></a> [cloudwatch\_loginsights\_cis\_queries\_opg](#module\_cloudwatch\_loginsights\_cis\_queries\_opg) | ./modules/cis_queries | n/a |
| <a name="module_cloudwatch_loginsights_cis_queries_provisioned"></a> [cloudwatch\_loginsights\_cis\_queries\_provisioned](#module\_cloudwatch\_loginsights\_cis\_queries\_provisioned) | ./modules/cis_queries | n/a |
| <a name="module_cost_anomaly_detection"></a> [cost\_anomaly\_detection](#module\_cost\_anomaly\_detection) | ./modules/ce_anomaly_detection | n/a |
| <a name="module_custom_cloudwatch_alarms"></a> [custom\_cloudwatch\_alarms](#module\_custom\_cloudwatch\_alarms) | ./modules/custom_cloudwatch_alarms | n/a |
| <a name="module_custom_cloudwatch_alarms_vendored"></a> [custom\_cloudwatch\_alarms\_vendored](#module\_custom\_cloudwatch\_alarms\_vendored) | ./modules/custom_cloudwatch_alarms | n/a |
| <a name="module_data_access"></a> [data\_access](#module\_data\_access) | ./modules/default_roles | n/a |
| <a name="module_eu-west-1"></a> [eu-west-1](#module\_eu-west-1) | ./modules/region | n/a |
| <a name="module_eu-west-2"></a> [eu-west-2](#module\_eu-west-2) | ./modules/region | n/a |
| <a name="module_github_oidc_provider"></a> [github\_oidc\_provider](#module\_github\_oidc\_provider) | ./modules/github_oidc_provider | n/a |
| <a name="module_github_oidc_role_cost_data"></a> [github\_oidc\_role\_cost\_data](#module\_github\_oidc\_role\_cost\_data) | ./modules/github_oidc_roles | n/a |
| <a name="module_github_oidc_role_uptime_data"></a> [github\_oidc\_role\_uptime\_data](#module\_github\_oidc\_role\_uptime\_data) | ./modules/github_oidc_roles | n/a |
| <a name="module_global_multiregion_resources"></a> [global\_multiregion\_resources](#module\_global\_multiregion\_resources) | ./modules/global | n/a |
| <a name="module_onboarding"></a> [onboarding](#module\_onboarding) | ./modules/default_roles | n/a |
| <a name="module_operator"></a> [operator](#module\_operator) | ./modules/default_roles | n/a |
| <a name="module_security_hub"></a> [security\_hub](#module\_security\_hub) | ./modules/security_hub | n/a |
| <a name="module_slack_notifications"></a> [slack\_notifications](#module\_slack\_notifications) | ./modules/slack_notifications | n/a |
| <a name="module_viewer"></a> [viewer](#module\_viewer) | ./modules/default_roles | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_account_alternate_contact.operations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_alternate_contact.security](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_alternate_contact) | resource |
| [aws_account_primary_contact.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/account_primary_contact) | resource |
| [aws_ebs_encryption_by_default.enabled](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_encryption_by_default) | resource |
| [aws_guardduty_detector.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_detector) | resource |
| [aws_iam_account_alias.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_alias) | resource |
| [aws_iam_account_password_policy.strict](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |
| [aws_iam_policy.missing_view_only_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.aws_srt_support](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.sns_failure_feedback](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.sns_success_feedback](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.sns_failure_feedback](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.sns_success_feedback](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.additional_data_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.additional_viewer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws_billing_access_for_operator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws_srt_support_managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws_support_access_for_breakglass](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_service_linked_role.config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_service_linked_role) | resource |
| [aws_oam_link.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/oam_link) | resource |
| [aws_s3_account_public_access_block.block_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_account_public_access_block) | resource |
| [aws_shield_drt_access_role_arn_association.aws_srt_support_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/shield_drt_access_role_arn_association) | resource |
| [aws_cloudwatch_log_group.cloudtrail_log_group_vendored](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudwatch_log_group) | data source |
| [aws_iam_policy_document.aws_srt_support_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cost_metrics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.missing_view_only_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_feedback_actions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_feedback_assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.uptime_metrics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | Account Name | `string` | n/a | yes |
| <a name="input_auto_enable_controls"></a> [auto\_enable\_controls](#input\_auto\_enable\_controls) | Whether to automatically enable new controls when they are added to standards that are enabled | `bool` | `true` | no |
| <a name="input_aws_account_alternate_contact"></a> [aws\_account\_alternate\_contact](#input\_aws\_account\_alternate\_contact) | The alternate contacts for the account. | <pre>object({<br/>    operations = object({<br/>      name          = string<br/>      title         = string<br/>      email_address = string<br/>      phone_number  = string<br/>    })<br/>    security = object({<br/>      name          = string<br/>      title         = string<br/>      email_address = string<br/>      phone_number  = string<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_aws_account_primary_contact"></a> [aws\_account\_primary\_contact](#input\_aws\_account\_primary\_contact) | The primary contact for the account. | <pre>object({<br/>    address_line_1  = string<br/>    address_line_2  = string<br/>    city            = string<br/>    company_name    = string<br/>    country_code    = string<br/>    phone_number    = string<br/>    postal_code     = string<br/>    state_or_region = string<br/>    full_name       = string<br/>  })</pre> | n/a | yes |
| <a name="input_aws_config_enabled"></a> [aws\_config\_enabled](#input\_aws\_config\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_aws_iam_account_alias"></a> [aws\_iam\_account\_alias](#input\_aws\_iam\_account\_alias) | The AWS IAM Account Alias to use for the account | `string` | n/a | yes |
| <a name="input_aws_macie2_finding_publishing_frequency"></a> [aws\_macie2\_finding\_publishing\_frequency](#input\_aws\_macie2\_finding\_publishing\_frequency) | n/a | `string` | `"SIX_HOURS"` | no |
| <a name="input_aws_macie2_status"></a> [aws\_macie2\_status](#input\_aws\_macie2\_status) | Whether AWS Macie Infra in created in either 'ENABLED' or 'PAUSED' mode, or not created and 'DISABLED' completely | `string` | n/a | yes |
| <a name="input_aws_s3_account_block_public_access_enable"></a> [aws\_s3\_account\_block\_public\_access\_enable](#input\_aws\_s3\_account\_block\_public\_access\_enable) | Whether Amazon S3 should enable public blocks for buckets in this account. Defaults to False. | `bool` | `false` | no |
| <a name="input_aws_s3_account_block_public_acls"></a> [aws\_s3\_account\_block\_public\_acls](#input\_aws\_s3\_account\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_aws_s3_account_block_public_policy"></a> [aws\_s3\_account\_block\_public\_policy](#input\_aws\_s3\_account\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_aws_s3_account_ignore_public_acls"></a> [aws\_s3\_account\_ignore\_public\_acls](#input\_aws\_s3\_account\_ignore\_public\_acls) | Whether Amazon S3 should ignore public ACLs for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_aws_s3_account_restrict_public_buckets"></a> [aws\_s3\_account\_restrict\_public\_buckets](#input\_aws\_s3\_account\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_aws_security_hub_enabled"></a> [aws\_security\_hub\_enabled](#input\_aws\_security\_hub\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_aws_slack_cost_anomaly_notification_channel"></a> [aws\_slack\_cost\_anomaly\_notification\_channel](#input\_aws\_slack\_cost\_anomaly\_notification\_channel) | Slack's internal ID for the channel you want to post cost anomalies to. Format AB1C2DEF | `string` | `""` | no |
| <a name="input_aws_slack_health_notification_channel"></a> [aws\_slack\_health\_notification\_channel](#input\_aws\_slack\_health\_notification\_channel) | Slack's internal ID for the channel you want to post health alrets to. Format AB1C2DEF | `string` | `""` | no |
| <a name="input_aws_slack_notifications_enabled"></a> [aws\_slack\_notifications\_enabled](#input\_aws\_slack\_notifications\_enabled) | Whether to enable alerting to slack. To be used with slack cost/health notification channel. | `bool` | `false` | no |
| <a name="input_breakglass_base_policy_arn"></a> [breakglass\_base\_policy\_arn](#input\_breakglass\_base\_policy\_arn) | n/a | `string` | `"arn:aws:iam::aws:policy/AdministratorAccess"` | no |
| <a name="input_breakglass_create_instance_profile"></a> [breakglass\_create\_instance\_profile](#input\_breakglass\_create\_instance\_profile) | n/a | `bool` | `false` | no |
| <a name="input_breakglass_custom_policy_json"></a> [breakglass\_custom\_policy\_json](#input\_breakglass\_custom\_policy\_json) | n/a | `string` | `""` | no |
| <a name="input_ci_base_policy_arn"></a> [ci\_base\_policy\_arn](#input\_ci\_base\_policy\_arn) | n/a | `string` | `"arn:aws:iam::aws:policy/AdministratorAccess"` | no |
| <a name="input_ci_custom_policy_json"></a> [ci\_custom\_policy\_json](#input\_ci\_custom\_policy\_json) | n/a | `string` | `""` | no |
| <a name="input_cis_1_2_foundation_control_1_14_enabled"></a> [cis\_1\_2\_foundation\_control\_1\_14\_enabled](#input\_cis\_1\_2\_foundation\_control\_1\_14\_enabled) | When true, creates a metric filter and alarm for CIS.1.14. When false, sets standard control to disabled. | `bool` | `false` | no |
| <a name="input_cis_1_2_foundation_control_3_10_custom_filter"></a> [cis\_1\_2\_foundation\_control\_3\_10\_custom\_filter](#input\_cis\_1\_2\_foundation\_control\_3\_10\_custom\_filter) | When provided, creates a custom metric filter and alarm for CIS.3.10 and disables the control in security hub. | `string` | `""` | no |
| <a name="input_cis_1_2_foundation_control_3_10_enabled"></a> [cis\_1\_2\_foundation\_control\_3\_10\_enabled](#input\_cis\_1\_2\_foundation\_control\_3\_10\_enabled) | When true, creates a metric filter and alarm for CIS.3.10. When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_cis_1_2_foundation_control_3_11_enabled"></a> [cis\_1\_2\_foundation\_control\_3\_11\_enabled](#input\_cis\_1\_2\_foundation\_control\_3\_11\_enabled) | When true, creates a metric filter and alarm for CIS.3.11. When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_cis_1_2_foundation_control_3_12_enabled"></a> [cis\_1\_2\_foundation\_control\_3\_12\_enabled](#input\_cis\_1\_2\_foundation\_control\_3\_12\_enabled) | When true, creates a metric filter and alarm for CIS.3.12. When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_cis_1_2_foundation_control_3_13_enabled"></a> [cis\_1\_2\_foundation\_control\_3\_13\_enabled](#input\_cis\_1\_2\_foundation\_control\_3\_13\_enabled) | When true, creates a metric filter and alarm for CIS.3.13. When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_cis_1_2_foundation_control_3_14_enabled"></a> [cis\_1\_2\_foundation\_control\_3\_14\_enabled](#input\_cis\_1\_2\_foundation\_control\_3\_14\_enabled) | When true, creates a metric filter and alarm for CIS.3.14. When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_cis_1_2_foundation_control_3_4_enabled"></a> [cis\_1\_2\_foundation\_control\_3\_4\_enabled](#input\_cis\_1\_2\_foundation\_control\_3\_4\_enabled) | When true, creates a metric filter and alarm for CIS.3.4. When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_cis_1_2_foundation_control_3_8_enabled"></a> [cis\_1\_2\_foundation\_control\_3\_8\_enabled](#input\_cis\_1\_2\_foundation\_control\_3\_8\_enabled) | When true, creates a metric filter and alarm for CIS.3.8. When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_cis_1_2_subscription_enabled"></a> [cis\_1\_2\_subscription\_enabled](#input\_cis\_1\_2\_subscription\_enabled) | Subscribes to Security Hub standard CIS 1.2.0 | `bool` | `true` | no |
| <a name="input_cis_3_0_subscription_enabled"></a> [cis\_3\_0\_subscription\_enabled](#input\_cis\_3\_0\_subscription\_enabled) | Subscribes to Security Hub standard CIS 3.0.0 | `bool` | `true` | no |
| <a name="input_cis_foundation_alarms_enabled"></a> [cis\_foundation\_alarms\_enabled](#input\_cis\_foundation\_alarms\_enabled) | Whether to create metrics alarms to support CIS Foundation compliance. Defaults to true. | `bool` | `true` | no |
| <a name="input_cis_metric_namespace"></a> [cis\_metric\_namespace](#input\_cis\_metric\_namespace) | The destination namespace of the CIS CloudWatch metric. | `string` | `"CISLogMetrics"` | no |
| <a name="input_cloudtrail_bucket_name"></a> [cloudtrail\_bucket\_name](#input\_cloudtrail\_bucket\_name) | trail name | `string` | `"cloudtrail"` | no |
| <a name="input_cloudtrail_trail_name"></a> [cloudtrail\_trail\_name](#input\_cloudtrail\_trail\_name) | trail name | `string` | `"cloudtrail"` | no |
| <a name="input_config_continuous_resource_recording"></a> [config\_continuous\_resource\_recording](#input\_config\_continuous\_resource\_recording) | Should the configuration recorder scan constantly or daily (set to false in dev accounts) | `bool` | `true` | no |
| <a name="input_control_finding_generator"></a> [control\_finding\_generator](#input\_control\_finding\_generator) | Updates whether the calling account has consolidated control findings turned on | `string` | `"STANDARD_CONTROL"` | no |
| <a name="input_cost_anomaly_immediate_schedule_threshold"></a> [cost\_anomaly\_immediate\_schedule\_threshold](#input\_cost\_anomaly\_immediate\_schedule\_threshold) | The value that triggers an immediate notification if the threshold is exceeded. By default, an absolute dollar value, but changing `threshold_expression_type` changes this to percentage. | `string` | `"10.0"` | no |
| <a name="input_cost_anomaly_notification_email_address"></a> [cost\_anomaly\_notification\_email\_address](#input\_cost\_anomaly\_notification\_email\_address) | Email address to use to send anomaly alerts to | `string` | `null` | no |
| <a name="input_cost_anomaly_threshold_expression_type"></a> [cost\_anomaly\_threshold\_expression\_type](#input\_cost\_anomaly\_threshold\_expression\_type) | Setting passed to the threshold\_expression to determine if the value (weekly\_schedule\_threshold\|immediate\_schedule\_threshold) is an absolute (ANOMALY\_TOTAL\_IMPACT\_ABSOLUTE) or percentage (ANOMALY\_TOTAL\_IMPACT\_PERCENTAGE) | `string` | `"ANOMALY_TOTAL_IMPACT_ABSOLUTE"` | no |
| <a name="input_cost_anomaly_weekly_schedule_threshold"></a> [cost\_anomaly\_weekly\_schedule\_threshold](#input\_cost\_anomaly\_weekly\_schedule\_threshold) | The value that triggers a weekly notification if the threshold is exceeded. By default, an absolute dollar value, but changing `threshold_expression_type` changes this to percentage. | `string` | `"100.0"` | no |
| <a name="input_custom_alarms_breakglass_login_alarm_enabled"></a> [custom\_alarms\_breakglass\_login\_alarm\_enabled](#input\_custom\_alarms\_breakglass\_login\_alarm\_enabled) | Enable or disable the breakglass login alarm | `bool` | `true` | no |
| <a name="input_data_access_base_policy_arn"></a> [data\_access\_base\_policy\_arn](#input\_data\_access\_base\_policy\_arn) | n/a | `string` | `"arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"` | no |
| <a name="input_data_access_create_instance_profile"></a> [data\_access\_create\_instance\_profile](#input\_data\_access\_create\_instance\_profile) | n/a | `bool` | `false` | no |
| <a name="input_data_access_custom_policy_json"></a> [data\_access\_custom\_policy\_json](#input\_data\_access\_custom\_policy\_json) | n/a | `string` | `""` | no |
| <a name="input_enable_default_standards"></a> [enable\_default\_standards](#input\_enable\_default\_standards) | Whether to enable the security standards that Security Hub has designated as automatically enabled | `bool` | `false` | no |
| <a name="input_enable_guardduty"></a> [enable\_guardduty](#input\_enable\_guardduty) | n/a | `bool` | `true` | no |
| <a name="input_fsbp_standard_control_elb_6_enabled"></a> [fsbp\_standard\_control\_elb\_6\_enabled](#input\_fsbp\_standard\_control\_elb\_6\_enabled) | When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_github_oidc_enabled"></a> [github\_oidc\_enabled](#input\_github\_oidc\_enabled) | Enable an oidc provider in the account for use within github actions. Will create a stored query for the access log. | `bool` | `false` | no |
| <a name="input_has_onboarding_role"></a> [has\_onboarding\_role](#input\_has\_onboarding\_role) | Whether the account has an onboarding role (only for development accounts) | `bool` | `false` | no |
| <a name="input_is_production"></a> [is\_production](#input\_is\_production) | n/a | `bool` | `false` | no |
| <a name="input_modernisation_platform_account"></a> [modernisation\_platform\_account](#input\_modernisation\_platform\_account) | IF this is a vendored account from the Modernisation Platform | `bool` | `false` | no |
| <a name="input_oam_xray_sink_identifier_arn"></a> [oam\_xray\_sink\_identifier\_arn](#input\_oam\_xray\_sink\_identifier\_arn) | The identifier of the OAM Sink to duplicate XRay events to (if desired) | `string` | `null` | no |
| <a name="input_onboarding_base_policy_arn"></a> [onboarding\_base\_policy\_arn](#input\_onboarding\_base\_policy\_arn) | n/a | `string` | `"arn:aws:iam::aws:policy/ReadOnlyAccess"` | no |
| <a name="input_onboarding_custom_policy_json"></a> [onboarding\_custom\_policy\_json](#input\_onboarding\_custom\_policy\_json) | n/a | `string` | `""` | no |
| <a name="input_operator_base_policy_arn"></a> [operator\_base\_policy\_arn](#input\_operator\_base\_policy\_arn) | n/a | `string` | `"arn:aws:iam::aws:policy/ReadOnlyAccess"` | no |
| <a name="input_operator_create_instance_profile"></a> [operator\_create\_instance\_profile](#input\_operator\_create\_instance\_profile) | n/a | `bool` | `false` | no |
| <a name="input_operator_custom_policy_json"></a> [operator\_custom\_policy\_json](#input\_operator\_custom\_policy\_json) | n/a | `string` | `""` | no |
| <a name="input_pagerduty_securityhub_integration_key"></a> [pagerduty\_securityhub\_integration\_key](#input\_pagerduty\_securityhub\_integration\_key) | The PagerDuty integration key to subscribe to SecurityHub findings | `string` | `null` | no |
| <a name="input_product"></a> [product](#input\_product) | n/a | `string` | n/a | yes |
| <a name="input_shield_support_role_enabled"></a> [shield\_support\_role\_enabled](#input\_shield\_support\_role\_enabled) | Whether to create the Shield Support Role to allow AWS security engineers to access the account to assist with DDoS mitigation | `bool` | `false` | no |
| <a name="input_user_arns"></a> [user\_arns](#input\_user\_arns) | n/a | <pre>object({<br/>    view        = list(string)<br/>    operation   = list(string)<br/>    breakglass  = list(string)<br/>    data_access = list(string)<br/>    onboarding  = list(string)<br/>    ci          = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_viewer_base_policy_arn"></a> [viewer\_base\_policy\_arn](#input\_viewer\_base\_policy\_arn) | n/a | `string` | `"arn:aws:iam::aws:policy/ReadOnlyAccess"` | no |
| <a name="input_viewer_custom_policy_json"></a> [viewer\_custom\_policy\_json](#input\_viewer\_custom\_policy\_json) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_sns_topic_ce_detection_immediate_schedule"></a> [aws\_sns\_topic\_ce\_detection\_immediate\_schedule](#output\_aws\_sns\_topic\_ce\_detection\_immediate\_schedule) | n/a |
| <a name="output_aws_sns_topic_cis_aws_foundations_standard"></a> [aws\_sns\_topic\_cis\_aws\_foundations\_standard](#output\_aws\_sns\_topic\_cis\_aws\_foundations\_standard) | n/a |
| <a name="output_aws_sns_topic_custom_cloudwatch_alarms"></a> [aws\_sns\_topic\_custom\_cloudwatch\_alarms](#output\_aws\_sns\_topic\_custom\_cloudwatch\_alarms) | n/a |
| <a name="output_aws_sns_topic_slack_notification_failures"></a> [aws\_sns\_topic\_slack\_notification\_failures](#output\_aws\_sns\_topic\_slack\_notification\_failures) | n/a |
| <a name="output_ci_iam_role"></a> [ci\_iam\_role](#output\_ci\_iam\_role) | n/a |
