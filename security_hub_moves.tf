# Account Level Security Hub
moved {
  from = module.security_hub[0].aws_securityhub_account.main
  to   = aws_securityhub_account.main[0]
}

# Foundational Best Practices
moved {
  from = module.security_hub[0].aws_securityhub_standards_control.elb_6_application_load_balancer_deletion_protection_should_be_enabled
  to   = module.eu-west-1.module.security_hub_controls.aws_securityhub_standards_control.elb_6_application_load_balancer_deletion_protection_should_be_enabled
}
moved {
  from = module.security_hub[0].aws_securityhub_standards_control.iam_6_hardware_mfa_should_be_enabled_for_the_root_user
  to   = module.eu-west-1.module.security_hub_controls.aws_securityhub_standards_control.iam_6_hardware_mfa_should_be_enabled_for_the_root_user
}

moved {
  from = module.security_hub[0].aws_securityhub_standards_control.macie_1_macie_should_be_enabled
  to   = module.eu-west-1.module.security_hub_controls.aws_securityhub_standards_control.macie_1_macie_should_be_enabled
}

moved {
  from = module.security_hub[0].aws_securityhub_standards_control.macie_2_macie_should_be_enabled
  to   = module.eu-west-1.module.security_hub_controls.aws_securityhub_standards_control.macie_2_macie_should_be_enabled
}

# Resource Tagging Standards
moved {
  from = module.security_hub[0].aws_securityhub_standards_subscription.resource_tagging
  to   = module.eu-west-1.module.security_hub_controls.aws_securityhub_standards_subscription.resource_tagging
}

# CIS Foundations 3.0.0
moved {
  from = module.security_hub[0].aws_securityhub_standards_control.cis_3_0_iam_6_hardware_mfa_should_be_enabled_for_the_root_user[0]
  to   = module.eu-west-1.module.security_hub_controls.aws_securityhub_standards_control.cis_3_0_iam_6_hardware_mfa_should_be_enabled_for_the_root_user[0]
}

moved {
  from = module.security_hub[0].aws_securityhub_standards_subscription.cis_3_0[0]
  to   = module.eu-west-1.module.security_hub_controls.aws_securityhub_standards_subscription.cis_3_0[0]
}


# CIS SNS
moved {
  from = module.security_hub[0].aws_kms_alias.cis_aws_foundations_standard_sns
  to   = module.eu-west-1.module.security_hub_controls.aws_kms_alias.cis_aws_foundations_standard_sns
}

moved {
  from = module.security_hub[0].aws_kms_key.cis_aws_foundations_standard_sns
  to   = module.eu-west-1.module.security_hub_controls.aws_kms_key.cis_aws_foundations_standard_sns
}

moved {
  from = module.security_hub[0].aws_sns_topic.cis_aws_foundations_standard
  to   = module.eu-west-1.module.security_hub_controls.aws_sns_topic.cis_aws_foundations_standard
}

# PagerDuty Alerting
moved {
  from = module.security_hub[0].aws_cloudwatch_event_rule.security_hub[0]
  to   = module.eu-west-1.module.security_hub_controls.aws_cloudwatch_event_rule.security_hub[0]
}

moved {
  from = module.security_hub[0].aws_cloudwatch_event_target.sns[0]
  to   = module.eu-west-1.module.security_hub_controls.aws_cloudwatch_event_target.sns[0]
}

moved {
  from = module.security_hub[0].aws_sns_topic.security_hub[0]
  to   = module.eu-west-1.module.security_hub_controls.aws_sns_topic.security_hub[0]
}

moved {
  from = module.security_hub[0].aws_sns_topic_subscription.security_hub[0]
  to   = module.eu-west-1.module.security_hub_controls.aws_sns_topic_subscription.security_hub[0]
}

moved {
  from = module.security_hub[0].aws_sns_topic_policy.security_hub_topic_policy[0]
  to   = module.eu-west-1.module.security_hub_controls.aws_sns_topic_policy.security_hub_topic_policy[0]
}

# CIS 1.2
moved {
  from = module.security_hub[0].aws_securityhub_standards_control.toggled_control
  to   = module.eu-west-1.module.security_hub_controls.aws_securityhub_standards_control.toggled_control
}

moved {
  from = module.security_hub[0].aws_securityhub_standards_subscription.cis_1_2[0]
  to   = module.eu-west-1.module.security_hub_controls.aws_securityhub_standards_subscription.cis_1_2[0]
}

moved {
  from = module.security_hub[0].aws_securityhub_standards_control.cis_1_14_ensure_hardware_mfa_is_enabled_for_the_root_account
  to   = module.eu-west-1.module.security_hub_controls.aws_securityhub_standards_control.cis_1_14_ensure_hardware_mfa_is_enabled_for_the_root_account
}

moved {
  from = module.security_hub[0].aws_securityhub_standards_control.toggled_control
  to   = module.eu-west-1.module.security_hub_controls.aws_securityhub_standards_control.toggled_control
}

moved {
  from = module.security_hub[0].aws_cloudwatch_log_metric_filter.toggled_control
  to   = module.eu-west-1.module.security_hub_controls.aws_cloudwatch_log_metric_filter.toggled_control
}

moved {
  from = module.security_hub[0].aws_cloudwatch_metric_alarm.toggled_control
  to   = module.eu-west-1.module.security_hub_controls.aws_cloudwatch_metric_alarm.toggled_control
}
