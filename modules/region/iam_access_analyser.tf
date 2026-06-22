resource "aws_accessanalyzer_analyzer" "regional_external_access" {
  analyzer_name = "${var.product}-${var.account_name}-${data.aws_region.current.region}-external-access"
}

resource "aws_accessanalyzer_analyzer" "regional_unused_access" {
  count         = var.iam_access_analyser_unused_access_enabled ? 1 : 0
  analyzer_name = "${var.product}-${var.account_name}-${data.aws_region.current.region}-unused-access"
  type          = "ACCOUNT_UNUSED_ACCESS"

  configuration {
    unused_access {
      unused_access_age = "90"
    }
  }
}
