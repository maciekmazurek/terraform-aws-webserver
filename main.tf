provider "aws" {
  region = var.aws_region
}

# Downloading newest Ubuntu 22.04 LTS image
data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"] # Canonical ID

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
}

# Security group (firewall)
resource "aws_security_group" "web_sg" {
    name = "demo-web-sg"
    description = "Allow HTTP and SSH traffic"

    # Allow HTTP traffic
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow SSH traffic
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Outbound traffic without restrictions
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}