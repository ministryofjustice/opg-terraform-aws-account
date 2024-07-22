locals {
  github_oidc_production_policy = [
    data.aws_iam_policy_document.uptime_metrics.json,
    data.aws_iam_policy_document.cost_data.json
  ]
  github_oidc_non_production_policy = [
    data.aws_iam_policy_document.cost_data.json
  ]
  github_oidc_policy = var.is_production ? local.github_oidc_production_policy : local.github_oidc_non_production_policy
}

module "github_oidc_roles" {
  count       = var.github_oidc_enabled ? 1 : 0
  source      = "./modules/github_oidc_roles"
  name        = "reporting-gh-actions-run-reports"
  description = "Run OPG reports"
  repository  = var.github_oidc_repository

  custom_policy_documents = local.github_oidc_policy
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
data "aws_iam_policy_document" "cost_data" {
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
