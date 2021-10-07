variable "data_tier_vpc" { }

variable "data_tier_client" { }


variable "data_tier_default_config" {
  default = {
    volume_size   = 30
    Service = "data-tier"
    NetworkTier = "Private"
  }
}

variable "root_volume" {
  default = {
    volume_type = "gp2"
    volume_size = 30
}
}
variable "sg_id_data_tier" { }

variable "key-pair" { }

variable "subnet_id_private" { }

variable "private_key" { }

variable "pub_key" { }

variable "image" { }

variable "data_tier_node_type" { }
