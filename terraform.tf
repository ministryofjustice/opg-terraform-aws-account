terraform {
  required_version = ">= 1.1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9.0"
      configuration_aliases = [
        aws.eu-west-2,
        aws.global,
      ]
    }
  }
}

data "aws_region" "current" {}
