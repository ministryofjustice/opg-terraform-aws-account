terraform {

  backend "s3" {
    bucket         = "opg.terraform.state"
    key            = "example/services/service/terraform.tfstate"
    encrypt        = true
    region         = "eu-west-1"
    role_arn       = "arn:aws:iam::311462405659:role/state_write"
    dynamodb_table = "remote_lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.57.0"
    }
  }
  required_version = ">= 1.0.0"
}

variable "production_account_id" {
  type        = string
  description = "The AWS account ID"
}

variable "identity_account_id" {
  type        = string
  description = "The AWS account ID"
}

variable "DEFAULT_ROLE" {
  type        = string
  description = "The default role to assume"
  default     = "terraform"
}

provider "aws" {
  alias  = "identity"
  region = "eu-west-1"
  assume_role {
    role_arn     = "arn:aws:iam::${var.identity_account_id}:role/${var.DEFAULT_ROLE}"
    session_name = "terraform-session"
  }
}
provider "aws" {
  alias  = "production_eu_west_1"
  region = "eu-west-1"
  assume_role {
    role_arn     = "arn:aws:iam::${var.production_account_id}:role/${var.DEFAULT_ROLE}"
    session_name = "terraform-session"
  }
}

provider "aws" {
  alias  = "production_eu_west_2"
  region = "eu-west-2"
  assume_role {
    role_arn     = "arn:aws:iam::${var.production_account_id}:role/${var.DEFAULT_ROLE}"
    session_name = "terraform-session"
  }
}

provider "aws" {
  alias  = "production_global"
  region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::${var.production_account_id}:role/${var.DEFAULT_ROLE}"
    session_name = "terraform-session"
  }
}
