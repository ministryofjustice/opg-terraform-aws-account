terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.99.0"
      configuration_aliases = [
        aws.eu_west_1,
        aws.eu_west_2,
        aws.global,
      ]
    }
  }
  required_version = ">= 1.0.0"
}
