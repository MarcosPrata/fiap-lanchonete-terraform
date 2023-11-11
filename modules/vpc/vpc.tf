resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  enable_dns_hostnames = true

  tags = merge(
    var.tags,
    { "Name" : "${var.project_name}-vpc" }
  )
}
