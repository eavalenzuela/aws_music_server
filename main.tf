terraform {
    required_providers {
        aws = "~>2.5"
    }
}

provider "aws" {
    region = var.aws_region
    version = "~>2.5"
    shared_credentials_file = var.aws_credentials
    profile = var.aws_profile
}
