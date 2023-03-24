#Definicion de grupo de seguridad servidor EC2 con acceso al puerto 80,22,443
resource "aws_security_group" "mi_grupo_de_seguridad_publica" {
  name        = "server-ec2-publica-sg"
  description = "Allow ec2 demo inbound traffic"
  vpc_id      = module.vpc.vpc_id

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
    Name    = "server-ec2-publica-sg"
    Owner   = "Rossana"
    Project = "terraform"
  }
}

resource "aws_security_group" "mi_grupo_de_seguridad_privada" {
  name        = "server-ec2-privada-sg"
  description = "Allow ec2 demo inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    security_groups = [aws_security_group.mi_grupo_de_seguridad_publica.id]
    description = "Access Base de dato mysql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
  }
  ingress {
    security_groups = [aws_security_group.mi_grupo_de_seguridad_publica.id]
    description = "Access ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "server-ec2-publica-sg"
    Owner   = "Rossana"
    Project = "terraform"
  }
}

#Definicion de grupo de seguridad Balanceador de carga ALB con acceso al puerto 80,443
resource "aws_security_group" "mi_grupo_de_seguridad_alb" {
  name        = "alb-ec2-sg"
  description = "Allow ec2 demo inbound traffic"
  vpc_id      = module.vpc.vpc_id

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
    Name    = "alb-ec2-sg"
    Owner   = "Rossana"
    Project = "terraform"
  }
}