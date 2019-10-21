resource "aws_s3_bucket" "personal-terraform-states" {
  bucket        = "personal-terraform-states"
  acl           = "private"
  force_destroy = false
}
