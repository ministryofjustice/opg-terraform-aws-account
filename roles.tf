module "viewer" {
  source             = "./modules/default_roles"
  name               = "viewer"
  user_arns          = var.user_arns.view
  base_policy_arn    = var.viewer_base_policy_arn
  custom_policy_json = var.viewer_custom_policy_json
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
