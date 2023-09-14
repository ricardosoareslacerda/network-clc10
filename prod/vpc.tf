module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "prod"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true

  tags = {
    Terraform = "true"
  }
}

resource "aws_s3_bucket" "tfstate_bucket_prod" {
  bucket = "ricardo-prod-terraform-tfstate"

  tags = {
    Name        = "Terraform TFState Bucket"
    Environment = "Prod"
  }
}

resource "aws_s3_bucket_versioning" "versioning_tfstate_bucket" {
  bucket = aws_s3_bucket.tfstate_bucket_prod.id
  versioning_configuration {
    status = "Enabled"
  }
}