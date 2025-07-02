terraform {
  backend "s3" {
    bucket = "market-app-s3"
    key    = "terraform/backend/terraform.tfstate"
    region = "eu-north-1"
  }
}