terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.10.0"
    }
  }
  required_version = ">= 1.4.0"
  backend "s3" {
    bucket         = "aravindawstf"
    key            = "ntier-aws/terraform"
    region         = "us-west-1"
    dynamodb_table = "aravindawstf"
  }
}

provider "aws" {
  region = "us-west-1"
}