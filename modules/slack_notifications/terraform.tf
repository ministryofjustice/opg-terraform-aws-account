terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      configuration_aliases = [
        aws.eu-west-2,
        aws.global,
        aws.management
      ]
    }
  }
  required_version = ">= 1.1.5"
}
