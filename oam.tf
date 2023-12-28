resource "aws_oam_link" "main" {
  count           = var.oam_xray_sink_identifier == "" ? 0 : 1
  label_template  = "$AccountName"
  resource_types  = ["AWS::XRay::Trace"]
  sink_identifier = var.oam_xray_sink_identifier
}
