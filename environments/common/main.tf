provider "aws" {
  region = "ap-northeast-1"
}


# Key should be same as this dir name
terraform {
  required_version = ">= 0.12.10"

  backend "s3" {
    bucket = "personal-terraform-states"
    key    = "common/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
