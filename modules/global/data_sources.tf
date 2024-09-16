data "aws_default_tags" "current" {
  provider = aws.global
}

data "aws_caller_identity" "current" {
  provider = aws.global
}
