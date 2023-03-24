provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key = "" 
}

#AMI ami-0fe472d8a85bc7b0e Amazon linux
resource "aws_instance" "web" {
  ami           = "ami-0fe472d8a85bc7b0e"
  instance_type = "t2.micro" #capagratuita

  tags = {
    Name = "server-ec2"
    Owner = "Rossana"
    Project = "terraform"
  }
}