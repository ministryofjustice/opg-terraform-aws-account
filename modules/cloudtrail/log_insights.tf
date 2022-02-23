resource "aws_cloudwatch_query_definition" "cis_1_1" {
  name = "CIS-1.1-RootAccountUsage"

  log_group_names = [aws_cloudwatch_log_group.cloudtrail.name]

  query_string = <<EOF
fields @timestamp, sourceIPAddress, eventName, responseElements.ConsoleLogin
| filter userIdentity.type = "Root" and eventType !="AwsServiceEvent" and !ispresent(userIdentity.invokedBy)
| sort @timestamp desc
EOF
}

resource "aws_cloudwatch_query_definition" "cis_3_1" {
  name = "CIS-3.1-UnauthorisedAPICalls"

  log_group_names = [aws_cloudwatch_log_group.cloudtrail.name]

  query_string = <<EOF
fields @timestamp, eventSource, eventName, errorCode, userIdentity.principalId, userIdentity.sessionContext.sessionIssuer.userName
| filter errorCode like "UnauthorizedOperation" or  errorCode like "AccessDenied"
| sort @timestamp desc
EOF
}

resource "aws_cloudwatch_query_definition" "cis_3_2" {
  name = "CIS-3.2-ConsoleSigninWithoutMFA"

  log_group_names = [aws_cloudwatch_log_group.cloudtrail.name]

  query_string = <<EOF
fields @timestamp, sourceIPAddress, userIdentity.arn, eventName, responseElements.ConsoleLogin
| filter eventName = "ConsoleLogin" and additionalEventData.MFAUsed !="Yes"
| sort @timestamp desc
EOF
}

resource "aws_cloudwatch_query_definition" "cis_3_4" {
  name = "CIS-3.4-IAMPolicyChanges"

  log_group_names = [aws_cloudwatch_log_group.cloudtrail.name]

  query_string = <<EOF
fields @timestamp, eventName, requestParameters.roleName, requestParameters.policyName, userIdentity.sessionContext.sessionIssuer.userName
| filter eventName in ["DeleteGroupPolicy","DeleteRolePolicy","DeleteUserPolicy","PutGroupPolicy","PutRolePolicy","PutUserPolicy","CreatePolicy","DeletePolicy","CreatePolicyVersion","DeletePolicyVersion","AttachRolePolicy","DetachRolePolicy","AttachUserPolicy","DetachUserPolicy","AttachGroupPolicy","DetachGroupPolicy"cd ..
]
| sort @timestamp desc
EOF
}

resource "aws_cloudwatch_query_definition" "cis_3_8" {
  name = "CIS-3.8-S3BucketPolicyChanges"

  log_group_names = [aws_cloudwatch_log_group.cloudtrail.name]

  query_string = <<EOF
fields @timestamp, eventName, userIdentity.sessionContext.sessionIssuer.userName, requestParameters.bucketName
| filter eventSource = "s3.amazonaws.com" and eventName in ["PutBucketAcl","PutBucketPolicy","PutBucketCors","PutBucketLifecycle","PutBucketReplication","DeleteBucketPolicy","DeleteBucketCors","DeleteBucketLifecycle","DeleteBucketReplication"]
| sort @timestamp desc
EOF
}
