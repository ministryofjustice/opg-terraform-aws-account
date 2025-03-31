data "aws_iam_policy_document" "data_access" {
  source_policy_documents = [
    data.aws_iam_policy_document.allow_access_to_customer_data.json,
    data.aws_iam_policy_document.allow_access_to_logs.json
  ]
}

data "aws_iam_policy_document" "allow_access_to_customer_data" {
  statement {
    sid    = "AllowDynamoDBReadAccess"
    effect = "Allow"

    actions = [
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:GetItem"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowLogPIIReadAccess"
    effect = "Allow"

    actions = [
      "s3:GetObject*",
      "s3:ListJobs",
      "s3:ObjectOwnerOverrideToBucketOwner",
      "s3:PauseReplication",
      "s3:Replicate*",
    ]

    resources = ["*"]
  }
}
data "aws_iam_policy_document" "allow_access_to_logs" {
  statement {
    sid    = "AllowLogsQuery"
    effect = "Allow"

    actions = [
      "logs:StartQuery",
      "logs:StartLiveTail",
    ]

    resources = ["*"]
  }
}
