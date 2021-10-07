
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "region" {
  default = "###REGION###"
}

variable "client" {
  default = "###CLIENT###"
}

variable "private_key" {
  default = "./ssh_key/###SSH_KEY_NAME###"
}

variable "pub_key" {
  default = "./ssh_key/###SSH_KEY_NAME###.pub"
}



variable "availability_zone" {
  default = {
    zone1 = "a"
  }
}
variable "cidr_block" {
  default = "test1"
}

# # REPLACING ALL THE CREDS  VARIABLES WITH DEFAULT VALUE #



variable "image" {
  default = "###AMI###"
}


variable "server_ip" {
  default = "###SERVER_IP###"
}

variable "client_tier_node_type" {
  default = "###BASTION_NODE_TYPE###"
}

variable "data_tier_node_type" {
  default = "###MASTER_NODE_TYPE###"
}


