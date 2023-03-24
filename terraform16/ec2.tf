#primer servidor
#AMI ami-0fe472d8a85bc7b0e Amazon linux

resource "aws_instance" "wp_server_1" {
  ami                    = "ami-0fe472d8a85bc7b0e"
  instance_type          = "t2.micro" #capagratuita
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad_publica.id]
  subnet_id              = module.vpc.public_subnets[0]
  key_name               = "temporal-demo"
  user_data              = <<EOF
#!/bin/bash
yum update -y
yum install -y mysql
yum -y install telnet
yum install -y httpd
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
cd /var/www/html
wget https://wordpress.org/latest.tar.gz 
tar -xzf latest.tar.gz
sudo cp -r wordpress/*  /var/www/html/
chmod -R 755 wp-content
chown -R apache:apache wp-content
service httpd start
chkconfig httpd on
EOF
  tags = {
    Name    = "wp-terraform-ec2-1"
    Owner   = "Rossana"
    Project = "terraform"
  }
}
