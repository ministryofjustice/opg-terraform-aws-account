terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.95.0"
      configuration_aliases = [
        aws.eu_west_1,
        aws.eu_west_2,
      ]
    }
  }
  required_version = "1.11.4"
}
