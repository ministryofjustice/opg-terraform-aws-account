resource "aws_iam_role_policy_attachment" "additional_data_access" {
  depends_on = [module.data_access[0].aws_iam_role]
  role       = module.data_access[0].aws_iam_role.name
  policy_arn = aws_iam_policy.additional_data_access.arn
}


resource "aws_iam_policy" "additional_data_access" {
  depends_on  = [module.data_access[0].aws_iam_role]
  name        = "additional-data-access-policy"
  description = "Additional permissions that data access needs, left out by the AWS managed readonly policy."
  policy      = data.aws_iam_policy_document.additional_data_access.json
}

data "aws_iam_policy_document" "additional_data_access" {
  depends_on = [module.data_access[0].aws_iam_role]
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
