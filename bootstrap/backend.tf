terraform {
  backend "s3" {
    bucket         = "sp-01102026-aws-kub"
    key            = "openshift-migration/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    #dynamodb_table = "terraform-lock" # Required to prevent concurrent apply/destroy
  }
}