resource "aws_instance" "client_tier" {
  ami                         = var.image
  instance_type               = var.client_tier_node_type
  key_name                    = var.key-pair
  subnet_id                   = var.subnet_id_public
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.client_tier_sg]

   user_data = <<EOF
#!/bin/bash
sudo apt-get update -y
EOF


  root_block_device {
    volume_type = var.root_volume["volume_type"]
    volume_size = var.root_volume["volume_size"]
    encrypted   = "true"
  }

  tags = {
    Name                            = "${var.client_tier_client}-client-tier"
    Service                         = var.client_tier_default_config["Service"]
    NetworkTier                     = var.client_tier_default_config["NetworkTier"]
    Accessibility                   = "Public"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.client_tier.id
  allocation_id = var.client_tier_eip

 provisioner "file" {
    content      = file(var.private_key)
    destination  = "$HOME/.ssh/id_rsa"
  }


  provisioner "remote-exec" {
   inline = [

     "echo 'Can be used to call any scripts or execute any shell commands' "
    ]
 }
  connection {
    host         = var.client_tier_public_ip
    type         = "ssh"
    user         = "ubuntu"
    private_key  = file(var.private_key)
  }
}
