# Allocate Elastic IP Address (EIP1)
resource "aws_eip" "eip-for-nat-gateway-1" {
  vpc      = true
  tags = {
    Name = "${var.project_name}-EIP-1"
  }
}

# Allocate Elastic IP Address (EIP2)
resource "aws_eip" "eip-for-nat-gateway-2" {
  vpc      = true
  tags = {
    Name = "${var.project_name}-EIP-2"
  }
}

#create nat Gateway 1 in public subnet 1
resource "aws_nat_gateway" "nat-gateway-1" {
  allocation_id = aws_eip.eip-for-nat-gateway-1.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name = "${var.project_name}-NAT-gw-in-public-subnet-1"
  }
}

  #create nat Gateway 2 in public subnet 2
resource "aws_nat_gateway" "nat-gateway-2" {
  allocation_id =  aws_eip.eip-for-nat-gateway-2.id
  subnet_id     = aws_subnet.public-subnet-2.id

  tags = {
    Name = "${var.project_name}-NAT-gw-in-public-subnet-2"
  }
}

# Create private Route Table 1 and Add Route through nat gateway 1 
# terraform aws create route table
resource "aws_route_table" "private-route-table-1" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway-1.id
  }

  tags       = {
    Name     = "${var.project_name}-Private Route Table-1"
  }
}

# Associate Private Subnet 1 to "Private Route Table 1"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-1-route-table-association" {
  subnet_id           = aws_subnet.private-subnet-1.id
  route_table_id      = aws_route_table.private-route-table-1.id
}

# Associate Private Subnet 3 to "Private Route Table 1"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-3-route-table-association" {
  subnet_id           = aws_subnet.private-subnet-3.id
  route_table_id      = aws_route_table.private-route-table-1.id
}


# Create private Route Table 2 and Add Route through nat gateway 2
# terraform aws create route table
resource "aws_route_table" "private-route-table-2" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway-2.id
  }

  tags       = {
    Name     = "${var.project_name}-Private Route Table-2"
  }
}


# Associate Private Subnet 2 to "Private Route Table 2"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-2-route-table-association" {
  subnet_id           = aws_subnet.private-subnet-2.id
  route_table_id      = aws_route_table.private-route-table-2.id
}

# Associate Private Subnet 4 to "Private Route Table 2"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-4-route-table-association" {
  subnet_id           = aws_subnet.private-subnet-4.id
  route_table_id      = aws_route_table.private-route-table-2.id
}
