# Declare the data source for availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

# Create 2 Subnets in 2 Availability Zones
resource "aws_subnet" "subnet1" {
  count = 2
  vpc_id            = aws_vpc.example.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id
}

# Create a custom route table
resource "aws_route_table" "custom" {
  vpc_id = aws_vpc.example.id
}

# Create a route to the internet through the internet gateway
resource "aws_route" "internet" {
  route_table_id         = aws_route_table.custom.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.example.id
}