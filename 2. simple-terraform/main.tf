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

# Kreiranje ubuntu instance i instaliranje apache web servera i dodadavanje 
# teksta u html fajlu.

resource "aws_instance" "instance-1" {
  ami = "ami-0fabdb639e489a381"  # Ubuntu 22.04
  instance_type = "t2.micro"
  security_groups = [aws_security_group.instance]
  user_data = <<-EOF
        #!/bin/bash
        sudo apt update -y
        sudo apt install -y httpd
        systemctl start httpd
        systemctl enable httpd
        echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
        EOF
}

resource "aws_security_group" "instance" {
    name = "instance-security-group"
}

resource "aws_security_group_rule" "allow_http" {
  type = "ingress"
  security_group_id = aws_security_group.instance.id

  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ] # dozvoljava svima pristup preko porta 80
}

# data koristimo umesto resource kada je na AWS-u vec kreiran taj resurs
# ako zelimo da kreiramo svoj onda koristimo resource
data "aws_vpc" "default_vpc" {
    default = true
}

data "aws_subnet_ids" "default_subnet" {
    vpc_id = data.aws_vpc.default_vpc.id
}