output "vpc_id" {
  description = "VPC Id"
  value       = aws_vpc.main.id
  sensitive   = false
}

output "private_subnet_ids" {
  description = "Private subnet Ids"
  sensitive   = false
  value = [
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id
  ]
}

output "public_subnet_ids" {
  description = "Public subnet Ids"
  sensitive   = false
  value = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id
  ]
}
