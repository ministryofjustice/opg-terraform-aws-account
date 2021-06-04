variable "account_name" {
  default     = ""
  description = "Account Name"
  type        = string
}

variable "product" {
  default     = ""
  description = "Product/Service name"
  type        = string
}

variable "tags" {
  type        = map(any)
  description = "Tags to apply to all taggable resources"
}
