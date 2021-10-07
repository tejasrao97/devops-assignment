#########Define the security group for public client_tier node##########
resource "aws_security_group" "client_tier" {
  name        = "${var.s_group_client}-client_tier"
  description = "Security Group for client_tier"
  vpc_id      = var.s_group_vpc_id

  ingress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.s_group_vpc_cidr]

  }



###terraform server IP##

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.s_group_server_ip}/32"]
  }



##############Till here#######################


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.s_group_vpc_cidr]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

   egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.s_group_client}-client_tier"
  }
}


#########Define the security group for data_tier##########
resource "aws_security_group" "data_tier"{
  name = "${var.s_group_client}-data_tier"
  description = "Security Group for data_tier"
vpc_id = var.s_group_vpc_id


  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [var.s_group_vpc_cidr]

  }



ingress {
    from_port = 1
    to_port = 65535
    protocol = "tcp"
    security_groups = [aws_security_group.client_tier.id]

  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.s_group_vpc_cidr]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

   egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.s_group_client}-data_tier"
  }
}

