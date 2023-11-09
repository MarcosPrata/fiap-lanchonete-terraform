output "vpc_id" {
  description = "VPC Id"
  value       = aws_vpc.main.id
  sensitive   = false
}


output "public_subnet_id" {
  description = "Public Subnet Id"
  value       = aws_subnet.public_subnet.id
  sensitive   = false
}

output "private_subnet1_id" {
  description = "Private Subnet Id"
  value       = aws_subnet.private_subnet1.id
  sensitive   = false
}

output "private_subnet2_id" {
  description = "Private Subnet Id"
  value       = aws_subnet.private_subnet2.id
  sensitive   = false
}
