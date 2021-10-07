

resource "aws_nat_gateway" "nat_zone_1" {
  allocation_id = var.nat_gateway_eip
  subnet_id     = var.subnet_id_public

   tags = {
     Name     = "${var.nat_client}"
   }


}

