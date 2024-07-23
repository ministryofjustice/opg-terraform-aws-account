variable "name" {
  type        = string
  description = "The name of the role. Used for both policy and role"
}

variable "description" {
  type        = string
  description = "Description of the role"
}

variable "assumable_roles" {
  type        = list(string)
  description = "List of assumable roles"
  default     = []
}

variable "custom_policy_documents" {
  type        = list(any)
  description = "Policy documents to add to the role"
  default     = []
}


variable "permissions" {
  type        = list(string)
  description = "List of github permissions to scope the role to"
}
