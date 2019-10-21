provider "aws" {
  region = "ap-northeast-1"
}

provider "template" {
}

# Key should be same as this dir name
terraform {
  required_version = ">= 0.12.10"

  backend "s3" {
    bucket = "personal-terraform-states"
    # key prefix should be environment name, but can't change dynamically
    key    = "shadow-mistress/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

resource "aws_lightsail_instance" "main" {
  name              = var.instance_name
  availability_zone = var.az
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  key_pair_name     = var.key_pair_name

  tags = {
    CreatedAt = timestamp()
  }

  lifecycle {
    ignore_changes = [tags.CreatedAt]
  }
}


resource "aws_lightsail_static_ip" "main" {
  name = var.instance_name
}

resource "aws_lightsail_static_ip_attachment" "main" {
  static_ip_name = aws_lightsail_static_ip.main.name
  instance_name  = aws_lightsail_instance.main.name
}
