locals {
  add_uptime_oidc = var.github_oidc_enabled && var.is_production ? true : false
}
# OIDC role for fetching cost data from the account
module "github_oidc_role_cost_data" {
  count       = var.github_oidc_enabled ? 1 : 0
  source      = "./modules/github_oidc_roles"
  name        = "gh-actions-cost-metrics"
  description = "Run OPG costs reports"
  permissions = var.github_oidc_permissions

  custom_policy_documents = [data.aws_iam_policy_document.cost_metrics.json]
}

# OIDC role for fetching cloudwatch metrics relating to uptime checks
# Only added for production accounts
module "github_oidc_role_uptime_data" {
  count       = local.add_uptime_oidc ? 1 : 0
  source      = "./modules/github_oidc_roles"
  name        = "gh-actions-uptime-metrics"
  description = "Run OPG uptime reports"
  permissions = var.github_oidc_permissions

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
