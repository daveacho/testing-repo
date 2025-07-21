resource "aws_s3_bucket" "test_bucket" {
  bucket        = "my-test-random-bucket-a-a-a"
  force_destroy = true
}
