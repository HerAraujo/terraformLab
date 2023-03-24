output "public_ip" {
  description = "Direccion IP publica del servidor"
  value       = "http://${aws_instance.web.public_ip}"
}

output "public_dns" {
  description = "DNS publica del servidor"
  value       = "http://${aws_instance.web.public_dns}"
}
