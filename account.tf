resource "aws_iam_account_alias" "main" {
  account_alias = var.aws_iam_account_alias
  provider      = aws.global
}

resource "aws_account_primary_contact" "main" {
  address_line_1  = var.aws_account_primary_contact.address_line_1
  address_line_2  = var.aws_account_primary_contact.address_line_2
  city            = var.aws_account_primary_contact.city
  company_name    = var.aws_account_primary_contact.company_name
  country_code    = var.aws_account_primary_contact.country_code
  phone_number    = var.aws_account_primary_contact.phone_number
  postal_code     = var.aws_account_primary_contact.postal_code
  state_or_region = var.aws_account_primary_contact.state_or_region
  full_name       = var.aws_account_primary_contact.full_name
  provider        = aws.global
}

resource "aws_account_alternate_contact" "operations" {
  alternate_contact_type = "OPERATIONS"
  name                   = "OPG Webops Community"
  title                  = "Mx"
  email_address          = var.aws_account_alternate_contact_operations.email_address
  phone_number           = var.aws_account_alternate_contact_operations.phone_number
  provider               = aws.global
}
