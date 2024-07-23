locals {
  opg_reports_oidc_permissions = [
    "repo:ministryofjustice/opg-reports:pull_request",
    "repo:ministryofjustice/opg-reports:ref:refs/heads/*"
  ]

  oidc_uptime_enabled = var.github_oidc_enabled && var.is_production ? true : false

}
# OIDC role for fetching cost data from the account
module "github_oidc_role_cost_data" {
  count           = var.github_oidc_enabled ? 1 : 0
  source          = "./modules/github_oidc_roles"
  name            = "gh-actions-cost-metrics"
  description     = "Run OPG costs reports"
  permissions     = local.opg_reports_oidc_permissions
  assumable_roles = []

  custom_policy_documents = [data.aws_iam_policy_document.cost_metrics.json]
}

# OIDC role for fetching cloudwatch metrics relating to uptime checks
# Only added for production accounts
module "github_oidc_role_uptime_data" {
  count           = local.oidc_uptime_enabled ? 1 : 0
  source          = "./modules/github_oidc_roles"
  name            = "gh-actions-uptime-metrics"
  description     = "Run OPG uptime reports"
  permissions     = local.opg_reports_oidc_permissions
  assumable_roles = []

  custom_policy_documents = [data.aws_iam_policy_document.uptime_metrics.json]
}

# OIDC polices

# Used to get uptime stats
data "aws_iam_policy_document" "uptime_metrics" {
  version = "2012-10-17"

  statement {
    sid    = "CloudwatchMetrics"
    effect = "Allow"
    actions = [
      "cloudwatch:GetMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics"
    ]
    resources = ["*"]
  }
}

# Used to get cost data
data "aws_iam_policy_document" "cost_metrics" {
  version = "2012-10-17"

  statement {
    sid    = "CostExplorer"
    effect = "Allow"
    actions = [
      "ce:get*"
    ]
    resources = ["*"]
  }
}
