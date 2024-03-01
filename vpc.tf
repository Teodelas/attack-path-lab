resource "aws_vpc" "ebilling-vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} VPC"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-vpc"
    yor_trace = "4c6c539d-e290-4fe0-9abc-d7cfa50c0446"
  }
}
#Internet Gateway
resource "aws_internet_gateway" "ebilling-internet-gateway" {
  vpc_id = "${aws_vpc.ebilling-vpc.id}"
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} Internet Gateway"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-internet-gateway"
    yor_trace = "01e4577f-3a6a-454d-b430-4800c2e77d28"
  }
}
#Public Subnets
resource "aws_subnet" "ebilling-public-subnet-1" {
  availability_zone = "${var.region}a"
  cidr_block        = "10.10.10.0/24"
  vpc_id            = "${aws_vpc.ebilling-vpc.id}"
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} Public Subnet #1"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-public-subnet-1"
    yor_trace = "2afbce86-6fd2-48e6-a068-8e5b43f6d540"
  }
}
resource "aws_subnet" "ebilling-public-subnet-2" {
  availability_zone = "${var.region}b"
  cidr_block        = "10.10.20.0/24"
  vpc_id            = "${aws_vpc.ebilling-vpc.id}"
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} Public Subnet #2"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-public-subnet-2"
    yor_trace = "8b81895a-5b66-4a28-8629-e7e04b3a0988"
  }
}
#Public Subnet Routing Table
resource "aws_route_table" "ebilling-public-subnet-route-table" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ebilling-internet-gateway.id}"
  }
  vpc_id = "${aws_vpc.ebilling-vpc.id}"
  tags = {
    Name      = "ebilling ${random_string.bucket_suffix.result} Route Table for Public Subnet"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-public-subnet-route-table"
    yor_trace = "8042e8fe-97e6-4d57-bc6f-da3247ec3c60"
  }
}
#Public Subnets Routing Associations
resource "aws_route_table_association" "ebilling-public-subnet-1-route-association" {
  subnet_id      = "${aws_subnet.ebilling-public-subnet-1.id}"
  route_table_id = "${aws_route_table.ebilling-public-subnet-route-table.id}"
}
resource "aws_route_table_association" "ebilling-public-subnet-2-route-association" {
  subnet_id      = "${aws_subnet.ebilling-public-subnet-2.id}"
  route_table_id = "${aws_route_table.ebilling-public-subnet-route-table.id}"
}