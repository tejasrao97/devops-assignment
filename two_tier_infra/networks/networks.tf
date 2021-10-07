#####Create key pair
resource "aws_key_pair" "app-keypair" {
  key_name   = "${var.networks_client}-key"
  public_key = file("./ssh_key/${var.networks_client}.pub")
}

########Create_internet_gateway########
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = var.networks_vpc_id

  tags = {
    Name = "${var.networks_client}-Internet_gw"
}
}

##############public subnet##############

resource "aws_subnet" "public" {
  vpc_id = var.networks_vpc_id
  cidr_block = cidrsubnet(var.networks_cidr, 9, 130)
  availability_zone = "${var.networks_region}${var.networks_zones["zone1"]}"


  tags = {
    Name = "${var.networks_client}-public"
       }
   }

###############Private subnet############
resource "aws_subnet" "private" {
  vpc_id = var.networks_vpc_id
  cidr_block = cidrsubnet(var.networks_cidr, 9, 140)
#  availability_zone = "${var.networks_region}${var.networks_zone_1}"
  availability_zone = "${var.networks_region}${var.networks_zones["zone1"]}"


  tags = {
    Name = "${var.networks_client}-private"
    "kubernetes.io/cluster/kubeadm"     = "owned"
       }
   }

#########public route table###############

resource "aws_route_table" "route_table_public" {
  depends_on = [aws_internet_gateway.internet_gw]
  vpc_id     = var.networks_vpc_id

  tags = {
    Name = "${var.networks_client}-route-table-public"
    }
}

resource "aws_route" "route_table_public" {
  route_table_id         = aws_route_table.route_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gw.id
  depends_on             = [aws_route_table.route_table_public]
}


resource "aws_route_table_association" "route_table_association_zone_1" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.route_table_public.id

}



######################Private route table###################

resource "aws_route_table" "route_table_private" {
vpc_id = var.networks_vpc_id
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.nat_zone_1
  }
  tags = {
    Name = "${var.networks_client}-route-table-private"
  }
  }


resource "aws_route_table_association" "route_table_association_zone_1_private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.route_table_private.id
}


