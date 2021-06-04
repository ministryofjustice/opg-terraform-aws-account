variable "user_arns" {
  type    = list(string)
  default = []
}

variable "name" {}

variable "base_policy_arn" {
  default = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

variable "custom_policy_json" {
  default = ""
}

resource "aws_iam_role" "role" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.role.json
}

data "aws_iam_policy_document" "role" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.user_arns
    }

    actions = ["sts:AssumeRole", "sts:TagSession"]
  }
}

resource "aws_iam_role_policy_attachment" "base" {
  role       = aws_iam_role.role.id
  policy_arn = var.base_policy_arn
}

resource "aws_iam_role_policy" "custom" {
  policy = var.custom_policy_json != "" ? var.custom_policy_json : data.aws_iam_policy_document.default.json
  role   = aws_iam_role.role.id
}

data "aws_iam_policy_document" "default" {
  statement {
    sid = "default"
    actions = [
      "iam:Get*",
      "iam:List*"
    ]
    resources = ["*"]
  }
}