terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "test" {
  ami = "ami-011899242bb902164"
  instance_type = "t2.micro"
}