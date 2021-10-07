#---------creating Master Node instance-------------###
resource "aws_instance" "data_tier_node" {
#  depends_on = ["module.nat_gateway.nat_zone_1"]
  ami = var.image
  instance_type = var.data_tier_node_type
  key_name = var.key-pair
  vpc_security_group_ids = [var.sg_id_data_tier]
  subnet_id = var.subnet_id_private
  associate_public_ip_address = "false"
user_data = <<EOF
#!/bin/bash
sudo apt-get update -y
EOF


root_block_device {
    volume_type = var.root_volume["volume_type"]
    volume_size = var.root_volume["volume_size"]
    encrypted = "true"
  }





  tags = {

    Name                            = "${var.data_tier_client}-data_tier"
    Service                         = var.data_tier_default_config["Service"]
    NetworkTier                     = var.data_tier_default_config["NetworkTier"]
    Accessibility                   = "Private"

 }

}
