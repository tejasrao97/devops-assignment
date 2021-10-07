resource "aws_eip" "nat" {
  vpc = true

  tags = {

        Name     = "${var.eip_client}-nat-owned"
  }

}

resource "aws_eip" "client_tier" {
  vpc = true

  tags = {
        Name    = "${var.eip_client}-owned"
 }

}
