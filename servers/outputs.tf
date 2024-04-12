output "instances_ips" {
  description = "Public IP of instances"
  value       = aws_instance.t2micro[*].public_ip
}