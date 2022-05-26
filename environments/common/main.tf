terraform {
  required_version = ">=1.1.9"

  backend "s3" {
    bucket = "personal-terraform-states"
    key    = "common/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
