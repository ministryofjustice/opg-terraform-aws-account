terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.66.0"
      configuration_aliases = [
        aws.region,
      ]
    }
  }
  required_version = ">= 1.0.0"
}
