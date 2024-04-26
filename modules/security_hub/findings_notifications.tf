locals {
  security_hub_pagerduty_integration_enabled = var.pagerduty_securityhub_integration_key != null ? true : false
}

resource "aws_cloudwatch_event_rule" "security_hub" {
  count       = local.security_hub_pagerduty_integration_enabled ? 1 : 0
  name        = "securityhub_findings"
  description = "Findings from SecurityHub"

  event_pattern = jsonencode({
    "source" : "aws.securityhub",
    "detail-type" : ["Security Hub Findings - Imported"],
    "detail" : {
      "findings" : {
        "Severity" : {
          "Label" : ["HIGH", "CRITICAL"]
        }
      }
    }
  })
}

resource "aws_sns_topic" "security_hub" {
  count             = local.security_hub_pagerduty_integration_enabled ? 1 : 0
  name              = "SecurityHub-to-PagerDuty-${var.account_name}"
  fifo_topic        = false
  kms_master_key_id = "alias/aws/sns"
}

resource "aws_sns_topic_subscription" "security_hub" {
  count     = local.security_hub_pagerduty_integration_enabled ? 1 : 0
  topic_arn = aws_sns_topic.security_hub[0].arn
  protocol  = "https"
  endpoint  = "https://events.pagerduty.com/integration/${var.pagerduty_securityhub_integration_key}/enqueue"
}
