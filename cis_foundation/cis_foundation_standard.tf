data "aws_cloudwatch_log_group" "cloudtrail" {
  name = var.aws_cloudwatch_log_group_cloudtrail_name
}

resource "aws_cloudwatch_log_metric_filter" "root_account_usage" {
  name           = "CIS-1.1-RootAccountUsage"
  pattern        = "{$.userIdentity.type=\"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType !=\"AwsServiceEvent\"}"
  log_group_name = data.aws_cloudwatch_log_group.cloudtrail.name
  metric_transformation {
    name      = "EventCount"
    namespace = "CISLogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "root_account_usage" {
  actions_enabled     = true
  alarm_name          = "CIS-1.1-RootAccountUsage"
  alarm_actions       = [aws_sns_topic.cis_aws_foundations_standard.arn]
  ok_actions          = [aws_sns_topic.cis_aws_foundations_standard.arn]
  alarm_description   = "root login usage count"
  namespace           = "CISLogMetrics"
  metric_name         = "EventCount"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Sum"
  tags                = var.tags
  threshold           = 1
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_log_metric_filter" "unauthorised_api_calls" {
  name           = "CIS-3.1-UnauthorizedAPICalls"
  pattern        = "{($.errorCode=\"*UnauthorizedOperation\") || ($.errorCode=\"AccessDenied*\")}"
  log_group_name = data.aws_cloudwatch_log_group.cloudtrail.name
  metric_transformation {
    name      = "EventCount"
    namespace = "CISLogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "unauthorised_api_calls" {
  actions_enabled     = true
  alarm_name          = "CIS-3.1-UnauthorizedAPICalls"
  alarm_actions       = [aws_sns_topic.cis_aws_foundations_standard.arn]
  ok_actions          = [aws_sns_topic.cis_aws_foundations_standard.arn]
  alarm_description   = "unauthorised api call"
  namespace           = "CISLogMetrics"
  metric_name         = "EventCount"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Average"
  tags                = var.tags
  threshold           = 1
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_log_metric_filter" "console_sign_in_without_mfa" {
  name           = "CIS-3.2-ConsoleSigninWithoutMFA"
  pattern        = "{($.eventName=\"ConsoleLogin\") && ($.additionalEventData.MFAUsed !=\"Yes\")}"
  log_group_name = data.aws_cloudwatch_log_group.cloudtrail.name
  metric_transformation {
    name      = "EventCount"
    namespace = "CISLogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "console_sign_in_without_mfa" {
  actions_enabled     = true
  alarm_name          = "CIS-3.2-ConsoleSigninWithoutMFA"
  alarm_actions       = [aws_sns_topic.cis_aws_foundations_standard.arn]
  ok_actions          = [aws_sns_topic.cis_aws_foundations_standard.arn]
  alarm_description   = "console sign in without mfa count"
  namespace           = "CISLogMetrics"
  metric_name         = "EventCount"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Sum"
  tags                = var.tags
  threshold           = 1
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_log_metric_filter" "console_authentication_failure" {
  name           = "CIS-3.6-ConsoleAuthenticationFailure"
  pattern        = "{($.eventName=ConsoleLogin) && ($.errorMessage=\"Failed authentication\")}"
  log_group_name = data.aws_cloudwatch_log_group.cloudtrail.name
  metric_transformation {
    name      = "EventCount"
    namespace = "CISLogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "console_authentication_failure" {
  actions_enabled     = true
  alarm_name          = "CIS-3.6-ConsoleAuthenticationFailure"
  alarm_actions       = [aws_sns_topic.cis_aws_foundations_standard.arn]
  ok_actions          = [aws_sns_topic.cis_aws_foundations_standard.arn]
  alarm_description   = "console sign in without mfa count"
  namespace           = "CISLogMetrics"
  metric_name         = "EventCount"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = 60
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  statistic           = "Sum"
  tags                = var.tags
  threshold           = 1
  treat_missing_data  = "notBreaching"
}
