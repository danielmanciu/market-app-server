terraform {
  backend "s3" {
    bucket = "market-app-s3"
    key    = "terraform/backend/terraform.tfstate"
    region = "eu-north-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.3"
    }
  }
}


provider "aws" {
  region = "eu-north-1"
}