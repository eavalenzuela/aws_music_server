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

data "aws_ami" "ubuntu-19" {
    most_recent = true
    
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-eoan-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    
    owners = ["099720109477"]

}

# Set up keypair
resource "aws_key_pair" "aws_key" {
    key_name = "aws_key"
    public_key = var.aws_public_key
}
