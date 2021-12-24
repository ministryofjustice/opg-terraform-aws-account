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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.59.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.59.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_config"></a> [aws\_config](#module\_aws\_config) | ./config | n/a |
| <a name="module_billing"></a> [billing](#module\_billing) | ./default_roles | n/a |
| <a name="module_breakglass"></a> [breakglass](#module\_breakglass) | ./default_roles | n/a |
| <a name="module_ci"></a> [ci](#module\_ci) | ./default_roles | n/a |
| <a name="module_cloudtrail"></a> [cloudtrail](#module\_cloudtrail) | ./cloudtrail | n/a |
| <a name="module_operator"></a> [operator](#module\_operator) | ./default_roles | n/a |
| <a name="module_security_hub"></a> [security\_hub](#module\_security\_hub) | ./security_hub | n/a |
| <a name="module_viewer"></a> [viewer](#module\_viewer) | ./default_roles | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ebs_encryption_by_default.enabled](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_encryption_by_default) | resource |
| [aws_guardduty_detector.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_detector) | resource |
| [aws_iam_account_password_policy.strict](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |
| [aws_iam_role_policy_attachment.aws_inspector2_access_for_breakglass](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws_inspector2_access_for_ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws_support_access_for_breakglass](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_account_public_access_block.block_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_account_public_access_block) | resource |
| [aws_s3_bucket.s3_access_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.s3_access_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.s3_access_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_iam_policy_document.s3_access_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | Account Name | `string` | `""` | no |
| <a name="input_aws_s3_account_block_public_access_enable"></a> [aws\_s3\_account\_block\_public\_access\_enable](#input\_aws\_s3\_account\_block\_public\_access\_enable) | Whether Amazon S3 should enable public blocks for buckets in this account. Defaults to False. | `bool` | `false` | no |
| <a name="input_aws_s3_account_block_public_acls"></a> [aws\_s3\_account\_block\_public\_acls](#input\_aws\_s3\_account\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_aws_s3_account_block_public_policy"></a> [aws\_s3\_account\_block\_public\_policy](#input\_aws\_s3\_account\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_aws_s3_account_ignore_public_acls"></a> [aws\_s3\_account\_ignore\_public\_acls](#input\_aws\_s3\_account\_ignore\_public\_acls) | Whether Amazon S3 should ignore public ACLs for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_aws_s3_account_restrict_public_buckets"></a> [aws\_s3\_account\_restrict\_public\_buckets](#input\_aws\_s3\_account\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_baseline_security_enabled"></a> [baseline\_security\_enabled](#input\_baseline\_security\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_billing_base_policy_arn"></a> [billing\_base\_policy\_arn](#input\_billing\_base\_policy\_arn) | n/a | `string` | `"arn:aws:iam::aws:policy/job-function/Billing"` | no |
| <a name="input_billing_custom_policy_json"></a> [billing\_custom\_policy\_json](#input\_billing\_custom\_policy\_json) | n/a | `string` | `""` | no |
| <a name="input_breakglass_base_policy_arn"></a> [breakglass\_base\_policy\_arn](#input\_breakglass\_base\_policy\_arn) | n/a | `string` | `"arn:aws:iam::aws:policy/AdministratorAccess"` | no |
| <a name="input_breakglass_create_instance_profile"></a> [breakglass\_create\_instance\_profile](#input\_breakglass\_create\_instance\_profile) | n/a | `bool` | `false` | no |
| <a name="input_breakglass_custom_policy_json"></a> [breakglass\_custom\_policy\_json](#input\_breakglass\_custom\_policy\_json) | n/a | `string` | `""` | no |
| <a name="input_ci_base_policy_arn"></a> [ci\_base\_policy\_arn](#input\_ci\_base\_policy\_arn) | n/a | `string` | `"arn:aws:iam::aws:policy/AdministratorAccess"` | no |
| <a name="input_ci_custom_policy_json"></a> [ci\_custom\_policy\_json](#input\_ci\_custom\_policy\_json) | n/a | `string` | `""` | no |
| <a name="input_cis_foundation_alarms_enabled"></a> [cis\_foundation\_alarms\_enabled](#input\_cis\_foundation\_alarms\_enabled) | Whether to create metrics alarms to support CIS Foundation compliance. Defaults to true. | `bool` | `true` | no |
| <a name="input_cis_foundation_control_1_14_enabled"></a> [cis\_foundation\_control\_1\_14\_enabled](#input\_cis\_foundation\_control\_1\_14\_enabled) | When true, creates a metric filter and alarm for CIS.1.14. When false, sets standard control to disabled. | `bool` | `false` | no |
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
| <a name="output_aws_sns_topic_cis_aws_foundations_standard"></a> [aws\_sns\_topic\_cis\_aws\_foundations\_standard](#output\_aws\_sns\_topic\_cis\_aws\_foundations\_standard) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
