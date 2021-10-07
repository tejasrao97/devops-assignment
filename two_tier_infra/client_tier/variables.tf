variable "client_tier_region" { }

variable "client_tier_eip" { }

variable "client_tier_vpc" { }

variable "client_tier_client" {}
variable "subnet_id_public" { }

variable "client_tier_ak" { }

variable "client_tier_sk" { }

variable "client_tier_sg"{ }

variable "data_tier_ip" { }

variable "key-pair" { }

variable "private_key" { }

variable "pub_key" { }
variable "client_tier_default_config" {
  default = {
    volume_size   = 20
    Service = "client_tier"
    NetworkTier = "Public"
  }
  
}

variable "root_volume" {
  default = {
    volume_type = "gp2"
    volume_size = 30
}
}


variable "data_tier_sg_id" { }

variable "image" { }

variable "client_tier_node_type" { }

variable "client_tier_public_ip" { }
