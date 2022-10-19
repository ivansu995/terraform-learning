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
  ami = "ami-0fabdb639e489a381" # Eu West Ubuntu 22.04
  instance_type = "t2.micro"
}