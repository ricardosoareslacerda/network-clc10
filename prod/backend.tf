terraform {
  backend "s3" {
    bucket = "ricardo-prod-terraform-tfstate"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}