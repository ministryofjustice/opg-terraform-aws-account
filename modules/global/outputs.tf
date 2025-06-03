output "eu_west_1_macie_findings_encryption_key" {
  value = var.macie_enabled ? module.macie_findings_encryption_key.eu_west_1_target_key : null
}

output "eu_west_2_macie_findings_encryption_key" {
  value = var.macie_enabled ? module.macie_findings_encryption_key.eu_west_2_target_key : null
}
