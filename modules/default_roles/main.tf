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

variable "create_instance_profile" {
  type    = bool
  default = false
}

resource "aws_iam_role" "role" {
  name               = var.name
  assume_role_policy = var.create_instance_profile ? data.aws_iam_policy_document.instance_profile[0].json : data.aws_iam_policy_document.role.json
}

resource "aws_iam_instance_profile" "role" {
  count = var.create_instance_profile ? 1 : 0

  name = var.name
  role = aws_iam_role.role.name
}

data "aws_iam_policy_document" "role" {
  statement {
    sid    = "AllowIdentityUsersToAssumeRole"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.user_arns
    }

    actions = ["sts:AssumeRole", "sts:TagSession"]
  }
}

data "aws_iam_policy_document" "instance_profile" {
  count                   = var.create_instance_profile ? 1 : 0
  source_policy_documents = [data.aws_iam_policy_document.role.json]

  statement {
    sid    = "AllowEC2ToAssumeInstanceProfile"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


resource "aws_iam_role_policy_attachment" "base" {
  role       = aws_iam_role.role.id
  policy_arn = var.base_policy_arn
}

resource "aws_iam_role_policy" "custom" {
  name   = var.name
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

output "aws_iam_role" {
  value = aws_iam_role.role
}
