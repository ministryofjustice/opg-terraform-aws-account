resource "aws_wafv2_rule_group" "php2shell" {
  name     = "php2shell"
  scope    = "REGIONAL"
  capacity = 24

  rule {
    name     = "PHP2Shell"
    priority = 0

    action {
      block {}
    }

    statement {
      and_statement {
        statement {
          byte_match_statement {
            search_string         = "POST"
            positional_constraint = "EXACTLY"
            field_to_match {
              method {}
            }
            text_transformation {
              priority = 0
              type     = "NONE"
            }
          }
        }

        statement {
          or_statement {
            statement {
              byte_match_statement {
                search_string         = "PHPSESSID"
                positional_constraint = "EXACTLY"
                field_to_match {
                  cookies {
                    match_scope       = "KEY"
                    oversize_handling = "CONTINUE"
                    match_pattern {
                      all {}
                    }
                  }
                }
                text_transformation {
                  priority = 0
                  type     = "NONE"
                }
              }
            }
            statement {
              byte_match_statement {
                search_string         = "PHPSESSID"
                positional_constraint = "CONTAINS"
                field_to_match {
                  body {
                    oversize_handling = "CONTINUE"
                  }
                }
                text_transformation {
                  priority = 0
                  type     = "NONE"
                }
              }
            }
          }
        }

        statement {
          byte_match_statement {
            search_string         = "PHP_SESSION_UPLOAD_PROGRESS"
            positional_constraint = "CONTAINS"
            field_to_match {
              body {
                oversize_handling = "CONTINUE"
              }
            }
            text_transformation {
              priority = 0
              type     = "NONE"
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "PHP2Shell"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "php2shell"
    sampled_requests_enabled   = true
  }
}
