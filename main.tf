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

# EC2
resource "aws_instance" "web_server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
  #!/bin/bash
  apt-get update -y
  apt-get install -y ngnix
  systemctl start nginx
  systemctl enable nginx
  echo "<h1>Build with Terraform.</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Name = "Demo-Server"
    Environment = "Development"
  }
}
