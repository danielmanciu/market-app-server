terraform {
  backend "s3" {
    bucket = "market-app-s3"
    key    = "terraform/backend"
    region = "eu-north-1"
  }
}