locals {
  auth_domain = "token.actions.githubusercontent.com"
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "github_oidc_assume_role" {
  policy_id = "OIDCAssumeRole"
  version   = "2012-10-17"

  statement {
    sid     = "AllowGitHubOIDCToAssumeRoleViaWebIdentity"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.auth_domain}"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.auth_domain}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "${local.auth_domain}:sub"
      values   = var.permissions
    }
  }
}

# Role to create
resource "aws_iam_role" "oidc" {
  name                 = var.name
  assume_role_policy   = data.aws_iam_policy_document.github_oidc_assume_role.json
  max_session_duration = var.max_session_duration
}

# Roles the OIDC role is allowed to assume
data "aws_iam_policy_document" "oidc_assume_roles" {
  count = length(var.assumable_roles) == 0 ? 0 : 1
  statement {
    sid     = "OIDCStsAssume"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    resources = var.assumable_roles
  }
}


data "aws_iam_policy_document" "combined" {
  source_policy_documents = concat(
    var.custom_policy_documents,
    length(var.assumable_roles) == 0 ? [] : [data.aws_iam_policy_document.oidc_assume_roles[0].json],
  )
}

resource "aws_iam_role_policy" "oidc" {
  name   = var.name
  role   = aws_iam_role.oidc.name
  policy = data.aws_iam_policy_document.combined.json
}
