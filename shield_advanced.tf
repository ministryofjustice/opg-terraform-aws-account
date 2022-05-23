resource "aws_iam_role" "aws_srt_support" {
  name               = "AWSSRTSupport"
  description        = "Role for DDoS response team to review AWS resources in your account and to mitigate DDoS attacks against your infrastructure by creating WAF rules and AWS Shield protections."
  assume_role_policy = data.aws_iam_policy_document.aws_srt_support_assume_role_policy.json
}

data "aws_iam_policy_document" "aws_srt_support_assume_role_policy" {
  statement {
    sid     = "AllowAWSrtAssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["drt.shield.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role_policy_attachment" "aws_srt_support_managed_policy" {
  role       = aws_iam_role.aws_srt_support.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSShieldDRTAccessPolicy"
}
