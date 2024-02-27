terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.38"
      configuration_aliases = [
        aws.eu-west-2,
        aws.global,
        aws.management,
      ]
    }
  }
  required_version = ">= 1.1.5"
}
