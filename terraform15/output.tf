output "public_ip_1" {
  description = "Direccion IP Publica del servidor 1"
  value       = "http://${aws_instance.web.public_ip}"
}
output "public_ip_2" {
  description = "Direccion IP Public del servidor 2"
  value       = "http://${aws_instance.web1.public_ip}"
}

output "public_alb" {
  description = "Direccion DNS ALB"
  value       = "http://${aws_lb.server-alb.dns_name}"
}