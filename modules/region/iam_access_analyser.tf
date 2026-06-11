resource "aws_accessanalyzer_analyzer" "regional_external_access" {
  analyzer_name = "${var.product}-${var.account_name}-${data.aws_region.current.region}-external-access"
}
