variable "account_name" {
  type        = string
  description = "The name of the account."
}

variable "macie_enabled" {
  type        = bool
  default     = true
  description = "Whether AWS Macie has been intentionally disabled in the account."
}
