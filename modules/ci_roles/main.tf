data "aws_caller_identity" "current" {}

############################
# CI role with boundary enabled
############################
module "ci" {
  source                   = "../default_roles"
  name                     = "${var.service}-ci-boundary"
  user_arns                = var.user_arns
  base_policy_arn          = var.base_policy_arn
  custom_policy_json       = var.custom_policy_json
  permissions_boundary_arn = aws_iam_policy.ci_boundary.arn
}

############################
# Boundary Local Variables
############################
locals {
  ci_role_name = "${var.service}-ci-boundary"
  ci_role_arn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.ci_role_name}"

  protected_principal_names = ["ci", "operator", "viewer", "breakglass"]

  protected_role_arns = flatten([
    for n in local.protected_principal_names : [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${n}",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*/${n}",
    ]
  ])
}

############################
# Permissions boundary policy
############################
resource "aws_iam_policy" "ci_boundary" {
  name        = "${var.service}-ci-boundary"
  description = "Permission boundary for ${var.service} CI role"
  policy      = data.aws_iam_policy_document.ci_boundary_policy.json
}

data "aws_iam_policy_document" "ci_boundary_policy" {
  statement {
    sid    = "AllowBaselineSelectedServices"
    effect = "Allow"

    actions   = var.boundary
    resources = ["*"]
  }

  statement {
    sid    = "AllowIamReadMetaData"
    effect = "Allow"
    actions = [
      "iam:Get*",
      "iam:List*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "DenyBoundaryRemovalOnAnyPrincipal"
    effect = "Deny"
    actions = [
      "iam:DeleteRolePermissionsBoundary",
      "iam:DeleteUserPermissionsBoundary"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "ProtectBoundaryPolicies"
    effect = "Deny"
    actions = [
      "iam:CreatePolicyVersion",
      "iam:SetDefaultPolicyVersion",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:TagPolicy",
      "iam:UntagPolicy",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:AttachUserPolicy",
      "iam:DetachUserPolicy",
      "iam:AttachGroupPolicy",
      "iam:DetachGroupPolicy"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/${var.service}-ci-boundary",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/${var.service}-non-ci-boundary"
    ]
  }

  statement {
    sid    = "RequireBoundaryOnCreateRole"
    effect = "Deny"

    actions   = ["iam:CreateRole"]
    resources = ["*"]

    condition {
      test     = "StringNotEquals"
      variable = "iam:PermissionsBoundary"
      values   = [aws_iam_policy.non_ci_boundary.arn]
    }
  }

  statement {
    sid    = "RequireBoundaryOnPutRolePermissionsBoundary"
    effect = "Deny"

    actions   = ["iam:PutRolePermissionsBoundary"]
    resources = ["*"]

    condition {
      test     = "StringNotEquals"
      variable = "iam:PermissionsBoundary"
      values   = [aws_iam_policy.non_ci_boundary.arn]
    }
  }

  statement {
    sid    = "DenyAllUserModification"
    effect = "Deny"

    not_actions = [
      "iam:Get*",
      "iam:List*"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/*"
    ]
  }

  statement {
    sid    = "DenyModificationProtectedRoles"
    effect = "Deny"

    not_actions = [
      "iam:Get*",
      "iam:List*"
    ]
    resources = local.protected_role_arns
  }

  statement {
    sid    = "DenyAccessKeyLifecycle"
    effect = "Deny"
    actions = [
      "iam:CreateAccessKey",
      "iam:UpdateAccessKey",
      "iam:DeleteAccessKey"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "DenyConsoleCreds"
    effect = "Deny"
    actions = [
      "iam:CreateLoginProfile",
      "iam:UpdateLoginProfile",
      "iam:DeleteLoginProfile"
    ]
    resources = ["*"]
  }

  # Defence-in-depth: CI role itself is read-only (boundary-level)
  statement {
    sid    = "CiRoleSelfReadOnly"
    effect = "Deny"
    not_actions = [
      "iam:Get*",
      "iam:List*"
    ]
    resources = [local.ci_role_arn]
  }
}

############################
# Permissions boundary policy for roles created by CI
############################
resource "aws_iam_policy" "non_ci_boundary" {
  name        = "${var.service}-non-ci-boundary"
  description = "Permission boundary for roles created by CI"
  policy      = data.aws_iam_policy_document.non_ci_boundary_policy.json
}

data "aws_iam_policy_document" "non_ci_boundary_policy" {
  statement {
    sid    = "AllowSelectedServices"
    effect = "Allow"

    actions = var.boundary

    resources = ["*"]
  }

  statement {
    sid    = "AllowIamRead"
    effect = "Allow"
    actions = [
      "iam:Get*",
      "iam:List*"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "DenyECRMutating"
    effect = "Deny"
    actions = [
      "ecr:PutImage",
      "ecr:BatchDeleteImage",
      "ecr:DeleteRepository",
      "ecr:DeleteRepositoryPolicy",
      "ecr:SetRepositoryPolicy",
      "ecr:PutLifecyclePolicy",
      "ecr:DeleteLifecyclePolicy",
      "ecr:StartImageScan",
      "ecr:TagResource",
      "ecr:UntagResource",
      "ecr:PutImageTagMutability",
      "ecr:ReplicateImage"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "DenyIamWrite"
    effect = "Deny"

    actions = [
      "iam:Create*",
      "iam:Update*",
      "iam:Delete*",
      "iam:Put*",
      "iam:Attach*",
      "iam:Detach*"
    ]
    resources = ["*"]
  }
}

############################
# Guardrails policy attached to CI role
############################

resource "aws_iam_role_policy" "ci_guardrails" {
  name   = "${var.service}-ci-guardrails"
  role   = module.ci.aws_iam_role.id
  policy = data.aws_iam_policy_document.ci_guardrails.json
}

data "aws_iam_policy_document" "ci_guardrails" {
  statement {
    sid    = "CiRoleSelfReadOnlyInline"
    effect = "Deny"

    not_actions = [
      "iam:Get*",
      "iam:List*"
    ]

    resources = [module.ci.aws_iam_role.arn]
  }
}
