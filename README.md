# opg-terraform-aws-account
Managed by opg-org-infra &amp; Terraform

Provides standard default configuration for AWS accounts.

Creates default assumable roles for viewers, operators and breakglass access.
Creates cloudtrails in each account.
Sets up a strong password policy for IAM users.
Enables Guardduty

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws  | n/a     |

## Inputs

| Name                             | Description | Type                                                                                                                                                                                             | Default                                          | Required |
|----------------------------------|-------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------|:--------:|
| billing\_base\_policy\_arn       | n/a         | `string`                                                                                                                                                                                         | `"arn:aws:iam::aws:policy/job-function/Billing"` |    no    |
| billing\_custom\_policy\_json    | n/a         | `string`                                                                                                                                                                                         | `""`                                             |    no    |
| breakglass\_base\_policy\_arn    | n/a         | `string`                                                                                                                                                                                         | `"arn:aws:iam::aws:policy/AdministratorAccess"`  |    no    |
| breakglass\_custom\_policy\_json | n/a         | `string`                                                                                                                                                                                         | `""`                                             |    no    |
| ci\_base\_policy\_arn            | n/a         | `string`                                                                                                                                                                                         | `"arn:aws:iam::aws:policy/AdministratorAccess"`  |    no    |
| ci\_custom\_policy\_json         | n/a         | `string`                                                                                                                                                                                         | `""`                                             |    no    |
| cloudtrail\_bucket\_name         | trail name  | `string`                                                                                                                                                                                         | `"cloudtrail"`                                   |    no    |
| cloudtrail\_trail\_name          | trail name  | `string`                                                                                                                                                                                         | `"cloudtrail"`                                   |    no    |
| enable\_guardduty                | n/a         | `boolean`                                                                                                                                                                                        | `false`                                          |    no    |
| operator\_base\_policy\_arn      | n/a         | `string`                                                                                                                                                                                         | `"arn:aws:iam::aws:policy/ReadOnlyAccess"`       |    no    |
| operator\_custom\_policy\_json   | n/a         | `string`                                                                                                                                                                                         | `""`                                             |    no    |
| product                          | n/a         | `string`                                                                                                                                                                                         | n/a                                              |   yes    |
| user\_arns                       | n/a         | <pre>object({<br>    view       = list(string)<br>    operation  = list(string)<br>    breakglass = list(string)<br>    ci         = list(string)<br>    billing    = list(string)<br>  })</pre> | n/a                                              |   yes    |
| viewer\_base\_policy\_arn        | n/a         | `string`                                                                                                                                                                                         | `"arn:aws:iam::aws:policy/ReadOnlyAccess"`       |    no    |
| viewer\_custom\_policy\_json     | n/a         | `string`                                                                                                                                                                                         | `""`                                             |    no    |

## Outputs

No output.
