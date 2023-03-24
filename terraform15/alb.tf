### definicion del recurso balanceador de carga "ALB"

#ALB Application Load Balancer
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb

resource "aws_lb" "server-alb" {
  name               = "web-tf-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.mi_grupo_de_seguridad_alb.id]
  subnets            = [data.aws_subnet.zona_c.id, data.aws_subnet.zona_f.id]

  tags = {
    Owner   = "Rossana"
    Project = "terraform"
  }
}


#Resource: aws_lb_target_group
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group

resource "aws_lb_target_group" "server-tg" {
  name     = "web-tf-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    enabled  = true
    port     = 80
    path     = "/"
    protocol = "HTTP"
    matcher  = 200
  }
}

# aws_lb_target_group_attachment
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment

#tg attanch servidor 1
resource "aws_lb_target_group_attachment" "server1" {
  target_group_arn = aws_lb_target_group.server-tg.arn
  target_id        = aws_instance.web.id
  port             = 80
}

#tg attanch servidor 2
resource "aws_lb_target_group_attachment" "server2" {
  target_group_arn = aws_lb_target_group.server-tg.arn
  target_id        = aws_instance.web1.id
  port             = 80
}

#Resource AWS_LB_LISTENER
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.server-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.server-tg.arn
  }
}