terraform {
  backend "s3" {
    bucket = "my-first-practice-bucket-aaa"
    key    = "statefile/terraform.tfstate"
    #profile      = "terraform-user"
    region       = "eu-west-2"
    use_lockfile = false
  }
}