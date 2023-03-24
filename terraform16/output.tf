output "public_ip_1" {
  description = "Direccion IP Publica del servidor 1"
  value       = "http://${aws_instance.wp_server_1.public_ip}"
}

output "public_alb" {
  description = "Direccion DNS ALB"
  value       = "http://${aws_lb.server-alb.dns_name}"
}