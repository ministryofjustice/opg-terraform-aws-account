module "viewer" {
  source             = "./modules/default_roles"
  name               = "viewer"
  user_arns          = var.user_arns.view
  base_policy_arn    = var.viewer_base_policy_arn
  custom_policy_json = var.viewer_custom_policy_json
}

module "billing" {
  source             = "./modules/default_roles"
  name               = "billing"
  user_arns          = var.user_arns.billing
  base_policy_arn    = var.billing_base_policy_arn
  custom_policy_json = var.billing_custom_policy_json
}

data "aws_iam_policy_document" "aws_cost_explorer_access_for_billing" {
  statement {
    sid    = "AllowCostExplorerGet"
    effect = "Allow"
    actions = [
      "ce:get*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "aws_cost_explorer_access_for_billing" {
  name        = "CostExporerAccessForBillingRole"
  description = "Allow Cost Explorer API Get"
  policy      = data.aws_iam_policy_document.aws_cost_explorer_access_for_billing.json
}

resource "aws_iam_role_policy_attachment" "aws_cost_explorer_access_for_billing" {
  role       = module.billing.aws_iam_role.name
  policy_arn = aws_iam_policy.aws_cost_explorer_access_for_billing.arn
}

module "operator" {
  source                  = "./modules/default_roles"
  name                    = "operator"
  user_arns               = var.user_arns.operation
  base_policy_arn         = var.operator_base_policy_arn
  custom_policy_json      = var.operator_custom_policy_json
  create_instance_profile = var.operator_create_instance_profile
}

resource "aws_iam_role_policy_attachment" "aws_billing_access_for_operator" {
  role       = module.operator.aws_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSBillingReadOnlyAccess"
}

module "breakglass" {
  source                  = "./modules/default_roles"
  name                    = "breakglass"
  user_arns               = var.user_arns.breakglass
  base_policy_arn         = var.breakglass_base_policy_arn
  custom_policy_json      = var.breakglass_custom_policy_json
  create_instance_profile = var.breakglass_create_instance_profile
}

resource "aws_iam_role_policy_attachment" "aws_support_access_for_breakglass" {
  role       = module.breakglass.aws_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSSupportAccess"
}

module "ci" {
  source             = "./modules/default_roles"
  name               = "${var.product}-ci"
  user_arns          = var.user_arns.ci
  base_policy_arn    = var.ci_base_policy_arn
  custom_policy_json = var.ci_custom_policy_json
}


data "aws_iam_policy_document" "cloudwatch_reporting_policy" {
  statement {
    sid    = "AllowCloudWatchReports"
    effect = "Allow"
    actions = [
      "cloudwatch:GetMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
    ]
    resources = ["*"]
  }
}

module "cloudwatch_reporting" {
  count              = local.cloudwatch_reporting_role_enabled == true ? 1 : 0
  source             = "./modules/default_roles"
  name               = "cloudwatch-reporting-ci"
  user_arns          = var.user_arns.cloudwatch_reportng
  base_policy_arn    = "arn:aws:iam::aws:policy/AWSDenyAll"
  custom_policy_json = data.aws_iam_policy_document.cloudwatch_reporting_policy.json
}
