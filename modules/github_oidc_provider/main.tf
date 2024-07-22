# TLS certificate data
data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}


resource "aws_iam_openid_connect_provider" "this" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = ["sts.amazonaws.com"]

  # This thumbprint is taken from the https://token.actions.githubusercontent.com certificate
  thumbprint_list = data.tls_certificate.github.certificates[*].sha1_fingerprint
}

resource "aws_cloudwatch_query_definition" "oidc_assume_role_with_web_identity_logs" {
  name            = "Github OIDC AssumeRoleWithWebIdentity Logs"
  log_group_names = var.cloudtrail_trail_name

  query_string = <<EOF
fields @timestamp, errorCode, errorMessage, userIdentity.userName, @message
| filter eventName like "AssumeRoleWithWebIdentity"
| sort @timestamp desc
EOF
}
