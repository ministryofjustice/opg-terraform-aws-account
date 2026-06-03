variable "service" {
  type        = string
  description = "The name of the service"
  default     = "webops"
}

variable "user_arns" {
  type    = list(string)
  default = []
}

variable "boundary" {
  type    = list(string)
  default = []
}

variable "custom_policy_json" {
  type    = string
  default = ""
}

variable "base_policy_arn" {
  type    = string
  default = ""
}
