output "instance_ids" {
  description = "IDs of the EC2 instances"
  value       = aws_instance.this[*].id
}

output "instance_private_ips" {
  description = "Private IP addresses of the instances"
  value       = aws_instance.this[*].private_ip
}

output "instance_public_ips" {
  description = "Public IP addresses of the instances"
  value       = aws_instance.this[*].public_ip
}

output "eip_addresses" {
  description = "Elastic IP addresses associated with instances"
  value       = try(aws_eip.this[*].public_ip, [])
}

output "primary_network_interface_ids" {
  description = "Primary network interface IDs"
  value       = aws_instance.this[*].primary_network_interface_id
}
