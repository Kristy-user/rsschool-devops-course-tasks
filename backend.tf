terraform {
  backend "s3" {
    bucket         = "rs-devops-2025q2-terraform-state"
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

