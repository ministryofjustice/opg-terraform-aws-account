output "eu_west_1_macie_findings_encryption_key" {
  value = module.macie_findings_encryption_key.eu_west_1_target_key
}

output "eu_west_2_macie_findings_encryption_key" {
  value = module.macie_findings_encryption_key.eu_west_2_target_key
}
