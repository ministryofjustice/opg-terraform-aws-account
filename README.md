# opg-terraform-aws-account
Managed by opg-org-infra &amp; Terraform

Provides standard default configuration for AWS accounts.

Creates default assumable roles for viewers, operators and breakglass access.
Creates cloudtrails in each account.
Sets up a strong password policy for IAM users.
Enables Guardduty

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.34.0 |
| <a name="provider_aws.global"></a> [aws.global](#provider\_aws.global) | 4.34.0 |
| <a name="provider_aws.management"></a> [aws.management](#provider\_aws.management) | 4.34.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_cost_notifier"></a> [aws\_cost\_notifier](#module\_aws\_cost\_notifier) | git@github.com:ministryofjustice/opg-aws-cost-notifier.git | v1.2.0 |
| <a name="module_aws_health_notifier"></a> [aws\_health\_notifier](#module\_aws\_health\_notifier) | git@github.com:ministryofjustice/opg-aws-health-notifier.git | v1.2.0 |
| <a name="module_billing"></a> [billing](#module\_billing) | ./modules/default_roles | n/a |
| <a name="module_breakglass"></a> [breakglass](#module\_breakglass) | ./modules/default_roles | n/a |
| <a name="module_ci"></a> [ci](#module\_ci) | ./modules/default_roles | n/a |
| <a name="module_cloudtrail"></a> [cloudtrail](#module\_cloudtrail) | ./modules/cloudtrail | n/a |
| <a name="module_cost_anomaly_detection"></a> [cost\_anomaly\_detection](#module\_cost\_anomaly\_detection) | ./modules/ce_anomaly_detection | n/a |
| <a name="module_custom_cloudwatch_alarms"></a> [custom\_cloudwatch\_alarms](#module\_custom\_cloudwatch\_alarms) | ./modules/custom_cloudwatch_alarms | n/a |
| <a name="module_eu-west-1"></a> [eu-west-1](#module\_eu-west-1) | ./modules/region | n/a |
| <a name="module_eu-west-2"></a> [eu-west-2](#module\_eu-west-2) | ./modules/region | n/a |
| <a name="module_operator"></a> [operator](#module\_operator) | ./modules/default_roles | n/a |
| <a name="module_security_hub"></a> [security\_hub](#module\_security\_hub) | ./modules/security_hub | n/a |
| <a name="module_viewer"></a> [viewer](#module\_viewer) | ./modules/default_roles | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ebs_encryption_by_default.enabled](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_encryption_by_default) | resource |
| [aws_guardduty_detector.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_detector) | resource |
| [aws_iam_account_password_policy.strict](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |
| [aws_iam_role.aws_srt_support](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.sns_failure_feedback](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.sns_success_feedback](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.sns_failure_feedback](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.sns_success_feedback](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.aws_srt_support_managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws_support_access_for_breakglass](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_account_public_access_block.block_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_account_public_access_block) | resource |
| [aws_secretsmanager_secret.aws_notifier_slack_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.aws_notifier_slack_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_ecr_repository.cost_notifier_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_repository) | data source |
| [aws_ecr_repository.health_notifier_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_repository) | data source |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws_srt_support_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_feedback_actions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sns_feedback_assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_secretsmanager_secret.central_aws_notifier_slack_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.central_aws_notifier_slack_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | Account Name | `string` | `""` | no |
| <a name="input_auto_enable_controls"></a> [auto\_enable\_controls](#input\_auto\_enable\_controls) | Whether to automatically enable new controls when they are added to standards that are enabled | `bool` | `false` | no |
| <a name="input_aws_config_enabled"></a> [aws\_config\_enabled](#input\_aws\_config\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_aws_s3_account_block_public_access_enable"></a> [aws\_s3\_account\_block\_public\_access\_enable](#input\_aws\_s3\_account\_block\_public\_access\_enable) | Whether Amazon S3 should enable public blocks for buckets in this account. Defaults to False. | `bool` | `false` | no |
| <a name="input_aws_s3_account_block_public_acls"></a> [aws\_s3\_account\_block\_public\_acls](#input\_aws\_s3\_account\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_aws_s3_account_block_public_policy"></a> [aws\_s3\_account\_block\_public\_policy](#input\_aws\_s3\_account\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_aws_s3_account_ignore_public_acls"></a> [aws\_s3\_account\_ignore\_public\_acls](#input\_aws\_s3\_account\_ignore\_public\_acls) | Whether Amazon S3 should ignore public ACLs for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_aws_s3_account_restrict_public_buckets"></a> [aws\_s3\_account\_restrict\_public\_buckets](#input\_aws\_s3\_account\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_aws_security_hub_enabled"></a> [aws\_security\_hub\_enabled](#input\_aws\_security\_hub\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_aws_slack_cost_anomaly_notification_channel"></a> [aws\_slack\_cost\_anomaly\_notification\_channel](#input\_aws\_slack\_cost\_anomaly\_notification\_channel) | n/a | `string` | `""` | no |
| <a name="input_aws_slack_health_notification_channel"></a> [aws\_slack\_health\_notification\_channel](#input\_aws\_slack\_health\_notification\_channel) | n/a | `string` | `""` | no |
| <a name="input_aws_slack_notifications_enabled"></a> [aws\_slack\_notifications\_enabled](#input\_aws\_slack\_notifications\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_billing_base_policy_arn"></a> [billing\_base\_policy\_arn](#input\_billing\_base\_policy\_arn) | n/a | `string` | `"arn:aws:iam::aws:policy/job-function/Billing"` | no |
| <a name="input_billing_custom_policy_json"></a> [billing\_custom\_policy\_json](#input\_billing\_custom\_policy\_json) | n/a | `string` | `""` | no |
| <a name="input_breakglass_base_policy_arn"></a> [breakglass\_base\_policy\_arn](#input\_breakglass\_base\_policy\_arn) | n/a | `string` | `"arn:aws:iam::aws:policy/AdministratorAccess"` | no |
| <a name="input_breakglass_create_instance_profile"></a> [breakglass\_create\_instance\_profile](#input\_breakglass\_create\_instance\_profile) | n/a | `bool` | `false` | no |
| <a name="input_breakglass_custom_policy_json"></a> [breakglass\_custom\_policy\_json](#input\_breakglass\_custom\_policy\_json) | n/a | `string` | `""` | no |
| <a name="input_ci_base_policy_arn"></a> [ci\_base\_policy\_arn](#input\_ci\_base\_policy\_arn) | n/a | `string` | `"arn:aws:iam::aws:policy/AdministratorAccess"` | no |
| <a name="input_ci_custom_policy_json"></a> [ci\_custom\_policy\_json](#input\_ci\_custom\_policy\_json) | n/a | `string` | `""` | no |
| <a name="input_cis_foundation_alarms_enabled"></a> [cis\_foundation\_alarms\_enabled](#input\_cis\_foundation\_alarms\_enabled) | Whether to create metrics alarms to support CIS Foundation compliance. Defaults to true. | `bool` | `true` | no |
| <a name="input_cis_foundation_control_1_14_enabled"></a> [cis\_foundation\_control\_1\_14\_enabled](#input\_cis\_foundation\_control\_1\_14\_enabled) | When true, creates a metric filter and alarm for CIS.1.14. When false, sets standard control to disabled. | `bool` | `false` | no |
| <a name="input_cis_foundation_control_3_10_custom_filter"></a> [cis\_foundation\_control\_3\_10\_custom\_filter](#input\_cis\_foundation\_control\_3\_10\_custom\_filter) | When provided, creates a custom metric filter and alarm for CIS.3.10 and disables the control in security hub. | `string` | `""` | no |
| <a name="input_cis_foundation_control_3_10_enabled"></a> [cis\_foundation\_control\_3\_10\_enabled](#input\_cis\_foundation\_control\_3\_10\_enabled) | When true, creates a metric filter and alarm for CIS.3.10. When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_cis_foundation_control_3_11_enabled"></a> [cis\_foundation\_control\_3\_11\_enabled](#input\_cis\_foundation\_control\_3\_11\_enabled) | When true, creates a metric filter and alarm for CIS.3.11. When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_cis_foundation_control_3_12_enabled"></a> [cis\_foundation\_control\_3\_12\_enabled](#input\_cis\_foundation\_control\_3\_12\_enabled) | When true, creates a metric filter and alarm for CIS.3.12. When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_cis_foundation_control_3_13_enabled"></a> [cis\_foundation\_control\_3\_13\_enabled](#input\_cis\_foundation\_control\_3\_13\_enabled) | When true, creates a metric filter and alarm for CIS.3.13. When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_cis_foundation_control_3_14_enabled"></a> [cis\_foundation\_control\_3\_14\_enabled](#input\_cis\_foundation\_control\_3\_14\_enabled) | When true, creates a metric filter and alarm for CIS.3.14. When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_cis_foundation_control_3_4_enabled"></a> [cis\_foundation\_control\_3\_4\_enabled](#input\_cis\_foundation\_control\_3\_4\_enabled) | When true, creates a metric filter and alarm for CIS.3.4. When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_cis_foundation_control_3_8_enabled"></a> [cis\_foundation\_control\_3\_8\_enabled](#input\_cis\_foundation\_control\_3\_8\_enabled) | When true, creates a metric filter and alarm for CIS.3.8. When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_cis_metric_namespace"></a> [cis\_metric\_namespace](#input\_cis\_metric\_namespace) | The destination namespace of the CIS CloudWatch metric. | `string` | `"CISLogMetrics"` | no |
| <a name="input_cloudtrail_bucket_name"></a> [cloudtrail\_bucket\_name](#input\_cloudtrail\_bucket\_name) | trail name | `string` | `"cloudtrail"` | no |
| <a name="input_cloudtrail_trail_name"></a> [cloudtrail\_trail\_name](#input\_cloudtrail\_trail\_name) | trail name | `string` | `"cloudtrail"` | no |
| <a name="input_control_finding_generator"></a> [control\_finding\_generator](#input\_control\_finding\_generator) | Updates whether the calling account has consolidated control findings turned on | `string` | `"STANDARD_CONTROL"` | no |
| <a name="input_cost_anomaly_immediate_schedule_threshold"></a> [cost\_anomaly\_immediate\_schedule\_threshold](#input\_cost\_anomaly\_immediate\_schedule\_threshold) | The dollar value that triggers an immediate notification if the threshold is exceeded. | `number` | `10` | no |
| <a name="input_cost_anomaly_notification_email_address"></a> [cost\_anomaly\_notification\_email\_address](#input\_cost\_anomaly\_notification\_email\_address) | Email address to use to send anomaly alerts to | `string` | `null` | no |
| <a name="input_cost_anomaly_weekly_schedule_threshold"></a> [cost\_anomaly\_weekly\_schedule\_threshold](#input\_cost\_anomaly\_weekly\_schedule\_threshold) | The dollar value that triggers a weekly notification if the threshold is exceeded. | `number` | `100` | no |
| <a name="input_custom_alarms_breakglass_login_alarm_enabled"></a> [custom\_alarms\_breakglass\_login\_alarm\_enabled](#input\_custom\_alarms\_breakglass\_login\_alarm\_enabled) | Enable or disable the breakglass login alarm | `bool` | `true` | no |
| <a name="input_enable_default_standards"></a> [enable\_default\_standards](#input\_enable\_default\_standards) | Whether to enable the security standards that Security Hub has designated as automatically enabled | `bool` | `false` | no |
| <a name="input_enable_guardduty"></a> [enable\_guardduty](#input\_enable\_guardduty) | n/a | `bool` | `true` | no |
| <a name="input_fsbp_standard_control_elb_6_enabled"></a> [fsbp\_standard\_control\_elb\_6\_enabled](#input\_fsbp\_standard\_control\_elb\_6\_enabled) | When false, sets standard control to disabled. | `bool` | `true` | no |
| <a name="input_is_production"></a> [is\_production](#input\_is\_production) | n/a | `bool` | `false` | no |
| <a name="input_operator_base_policy_arn"></a> [operator\_base\_policy\_arn](#input\_operator\_base\_policy\_arn) | n/a | `string` | `"arn:aws:iam::aws:policy/ReadOnlyAccess"` | no |
| <a name="input_operator_create_instance_profile"></a> [operator\_create\_instance\_profile](#input\_operator\_create\_instance\_profile) | n/a | `bool` | `false` | no |
| <a name="input_operator_custom_policy_json"></a> [operator\_custom\_policy\_json](#input\_operator\_custom\_policy\_json) | n/a | `string` | `""` | no |
| <a name="input_product"></a> [product](#input\_product) | n/a | `string` | n/a | yes |
| <a name="input_team_email"></a> [team\_email](#input\_team\_email) | Team group email address for use in tags | `string` | `"opgteam@digital.justice.gov.uk"` | no |
| <a name="input_team_name"></a> [team\_name](#input\_team\_name) | Name of the Team looking after the Service | `string` | `"OPG"` | no |
| <a name="input_user_arns"></a> [user\_arns](#input\_user\_arns) | n/a | <pre>object({<br>    view       = list(string)<br>    operation  = list(string)<br>    breakglass = list(string)<br>    ci         = list(string)<br>    billing    = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_viewer_base_policy_arn"></a> [viewer\_base\_policy\_arn](#input\_viewer\_base\_policy\_arn) | n/a | `string` | `"arn:aws:iam::aws:policy/ReadOnlyAccess"` | no |
| <a name="input_viewer_custom_policy_json"></a> [viewer\_custom\_policy\_json](#input\_viewer\_custom\_policy\_json) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_sns_topic_ce_detection_immediate_schedule"></a> [aws\_sns\_topic\_ce\_detection\_immediate\_schedule](#output\_aws\_sns\_topic\_ce\_detection\_immediate\_schedule) | n/a |
| <a name="output_aws_sns_topic_cis_aws_foundations_standard"></a> [aws\_sns\_topic\_cis\_aws\_foundations\_standard](#output\_aws\_sns\_topic\_cis\_aws\_foundations\_standard) | n/a |
| <a name="output_aws_sns_topic_custom_cloudwatch_alarms"></a> [aws\_sns\_topic\_custom\_cloudwatch\_alarms](#output\_aws\_sns\_topic\_custom\_cloudwatch\_alarms) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
