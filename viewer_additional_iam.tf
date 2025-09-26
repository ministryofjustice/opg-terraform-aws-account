resource "aws_iam_role_policy_attachment" "additional_viewer" {
  role       = module.viewer.aws_iam_role.name
  policy_arn = aws_iam_policy.additional_viewer.arn
}


resource "aws_iam_policy" "additional_viewer" {
  name        = "additional-viewer-policy"
  description = "Additional permissions that viewer needs, left out by the AWS managed readonly policy."
  policy      = data.aws_iam_policy_document.additional_viewer.json
}

data "aws_iam_policy_document" "additional_viewer" {
  statement {
    sid    = "AllowFreetierGetAccount"
    effect = "Allow"
    actions = [
      "freetier:GetAccountPlanState",
      "freetier:ListAccountActivities",
      "uxc:GetAccountColor"
    ]
    resources = ["*"]
  }
}
