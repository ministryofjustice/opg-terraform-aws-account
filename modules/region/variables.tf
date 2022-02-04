variable "account_name" {
    default     = ""
    description = "Account Name"
    type        = string
}

variable "baseline_security_enabled" {
    type    = bool
    default = false
}

variable "config_iam_role" {
    description = "Iam role object for the config role."
}

variable "product" {
    type = string
}
