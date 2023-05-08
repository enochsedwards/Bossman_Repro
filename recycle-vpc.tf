#Create the VPC

#1. Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.MainInfrastructure}-vpc"
  }
}

#2. Create subnets
#2a.Create public subnet 1
resource "aws_subnet" "public-subnet-1" {
  vpc_id                                      = "${aws_vpc.vpc.id}"
  cidr_block                                  = var.public_subnet_1
  availability_zone                           = var.az_1_name
 

  tags = {
    Name = "${var.MainInfrastructure}-public-subnet-1"
  }
}

#2b.Create public subnet 2
resource "aws_subnet" "public-subnet-2" {
  vpc_id                                      = "${aws_vpc.vpc.id}"
  cidr_block                                  = var.public_subnet_2
  availability_zone                           = var.az_2_name
 

  tags = {
    Name = "${var.MainInfrastructure}-public-subnet-2"
  }
}

#2c.Create private subnet 1
resource "aws_subnet" "private-subnet-1" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = var.private_subnet_1
  availability_zone = var.az_1_name

  tags = {
    Name = "${var.MainInfrastructure}-private-subnet-1"
  }
}

#2d.Create private subnet 2
resource "aws_subnet" "private-subnet-2" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = var.private_subnet_2
  availability_zone = var.az_2_name

  tags = {
    Name = "${var.MainInfrastructure}-private-subnet-2"
  }
}

#3. Create Internet Gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.MainInfrastructure2}-internet-gateway"
  }
}

#4. Create Elastic IP Adress
resource "aws_eip" "elastic-iP" {

  tags = {
    Name = "${var.MainInfrastructure2}-elastic-iP"
  }
}

#5. Create NAT Gateway
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = "${aws_eip.elastic-iP.id}"
  subnet_id     = "${aws_subnet.public-subnet-2.id}"

  tags = {
    Name = "${var.MainInfrastructure2}-nat-gateway"
  }

}

#4. Create Route Tables

#4a.Create pub Route Table 
resource "aws_route_table" "public-route-table" {
  vpc_id = "${aws_vpc.vpc.id}"
  #The command below attaches the pulic route table to the Internet gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet-gateway.id}"
  }


  tags = {
    Name = "${var.MainInfrastructure2}-public-route-table"
  }
}

#4b.Create priv Route Table 
resource "aws_route_table" "private-route-table" {
  vpc_id = "${aws_vpc.vpc.id}"
  #The command below attaches the private route table to the NAT gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat-gateway.id}"
  }

  tags = {
    Name = "${var.MainInfrastructure2}-private-route-table"
  }
}

#5. Create All Networking Associations & Attachments
#5a. Attach public Route Table to public subnet 1
resource "aws_route_table_association" "Attach-Prod-pub-route-table-Prod-pub-sub1" {
  subnet_id      = "${aws_subnet.public-subnet-1.id}"
  route_table_id = "${aws_route_table.public-route-table.id}"
}

#5b. Attach public Route Table to public subnet 2
resource "aws_route_table_association" "Attach-Prod-pub-route-table-Prod-pub-sub2" {
  subnet_id      = "${aws_subnet.public-subnet-2.id}"
  route_table_id = "${aws_route_table.public-route-table.id}"
}

#5c. Attach private Route Table To private subnet 1
resource "aws_route_table_association" "Attach-Prod-priv-route-table-Prod-priv-sub1" {
  subnet_id      = "${aws_subnet.private-subnet-1.id}"
  route_table_id = "${aws_route_table.private-route-table.id}"
}

#5d. Attach private Route Table To private subnet 2
resource "aws_route_table_association" "Attach-Prod-priv-route-table-Prod-priv-sub2" {
  subnet_id      = "${aws_subnet.private-subnet-2.id}"
  route_table_id = "${aws_route_table.private-route-table.id}"
}

