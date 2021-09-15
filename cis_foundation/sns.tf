resource "aws_sns_topic" "cis_aws_foundations_standard" {
  name              = "cis_aws_foundations_standard"
  kms_master_key_id = "alias/aws/sns"
}

output "aws_sns_topic_cis_aws_foundations_standard" {
  value = aws_sns_topic.cis_aws_foundations_standard
}
