terraform {
  backend "s3" {
    bucket = "terraform-backend-cyprusays-stage"
    key    = "stage/terraform.tfstate"
    region = "eu-west-3"
  }
}
