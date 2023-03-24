provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAYPQEOWB7VPKAEN7O"
  secret_key = "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"
}

#Grupo Seguridad =SG
resource "aws_security_group" "hernan-sg-2" {
  name        = "hernan-sg-2"
  description = "Allow ec2 demo inbound traffic"
  vpc_id      = "vpc-044ab0faabc1fd559"

  ingress {
    description = "Access SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Access http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Access https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "hernan-server-ec2-v2"
    Owner   = "Hernan"
    Project = "terraform"
  }
}


#AMI ami-0fe472d8a85bc7b0e Amazon linux
resource "aws_instance" "web" {
  ami                    = "ami-0fe472d8a85bc7b0e"
  instance_type          = "t2.micro" #capagratuita
  vpc_security_group_ids = [aws_security_group.hernan-sg-2.id]
  subnet_id              = "subnet-0010d643d3b3839a1" #us-east-1c
  user_data              = <<EOF
#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y nginx1 
sudo service nginx enable
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Bootcamp Terraform Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">Welcome to &#127819; Bootcamp</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF
  tags = {
    Name    = "hernan-server-ec2-v2"
    Owner   = "Hernan"
    Project = "terraform"
  }
}
