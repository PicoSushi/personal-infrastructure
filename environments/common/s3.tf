resource "aws_s3_bucket" "personal-terraform-states" {
  bucket        = "personal-terraform-states"
  force_destroy = false
}
