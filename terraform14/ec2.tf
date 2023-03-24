#primer servidor
#AMI ami-0fe472d8a85bc7b0e Amazon linux
resource "aws_instance" "web" {
  ami                    = "ami-0fe472d8a85bc7b0e"
  instance_type          = "t2.micro" #capagratuita
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]
  subnet_id              = data.aws_subnet.zona_c.id
  user_data              = <<EOF
#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y nginx1 
sudo service nginx enable
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Bootcamp Terraform Server</title></head><body><h1>Welcome to &#128640; Bootcamp</h1></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF
  tags = {
    Name    = "server-ec2-1"
    Owner   = "Rossana"
    Project = "terraform"
  }
}

#segundo servidor
#AMI ami-0fe472d8a85bc7b0e Amazon linux
resource "aws_instance" "web1" {
  ami                    = "ami-0fe472d8a85bc7b0e"
  instance_type          = "t2.micro" #capagratuita
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]
  subnet_id              = data.aws_subnet.zona_f.id
  user_data              = <<EOF
#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y nginx1 
sudo service nginx enable
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Bootcamp Terraform Server</title></head><body><h1>Welcome to &#128640; Bootcamp</h1></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF
  tags = {
    Name    = "server-ec2-2"
    Owner   = "Rossana"
    Project = "terraform"
  }
}