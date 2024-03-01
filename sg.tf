#Security Groups
resource "aws_security_group" "ebilling-ec2-ssh-security-group" {
  name        = "ebilling-ec2-ssh-${random_string.bucket_suffix.result}"
  description = "ebilling ${random_string.bucket_suffix.result} Security Group for EC2 Instance over SSH"
  vpc_id      = "${aws_vpc.ebilling-vpc.id}"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ebilling_whitelist]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.ebilling-vpc.cidr_block]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags = {
    Name      = "ebilling-ec2-ssh-${random_string.bucket_suffix.result}"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-ec2-ssh-security-group"
    yor_trace = "be1849b6-9e91-4e90-b5f1-adb5e13c89cc"
  }
}

resource "aws_security_group" "ebilling-ec2-http-security-group" {
  name        = "ebilling-ec2-http-${random_string.bucket_suffix.result}"
  description = "ebilling ${random_string.bucket_suffix.result} Security Group for EC2 Instance over HTTP"
  vpc_id      = "${aws_vpc.ebilling-vpc.id}"
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    security_groups = [
      "${aws_security_group.ebilling-ec2-ssh-security-group.id}",
    ]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags = {
    Name      = "ebilling-ec2-http-${random_string.bucket_suffix.result}"
    Stack     = "${var.stack-name}"
    Scenario  = "${var.scenario-name}"
    yor_name  = "ebilling-ec2-http-security-group"
    yor_trace = "aa43c032-ae8b-4315-905b-f28ffd5631d1"
  }
}