resource "aws_db_subnet_group" "sub" {
  name= "wp-rds-subnet-group"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
}

resource "aws_db_instance" "worpressdb" {
  allocated_storage    = 20
  db_name              = "wordpress"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "wordpress_user"
  password             = "123456788"
  vpc_security_group_ids = [aws_security_group.mi_grupo_de_seguridad_privada.id]
  db_subnet_group_name = aws_db_subnet_group.sub.name
  skip_final_snapshot  = true
}