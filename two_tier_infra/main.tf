terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "vpc" {
  source = "./vpc"

  vpc_region   = var.region
  vpcCIDRblock = var.cidr_block
  vpc_client   = var.client
}

module "eip" {
  source     = "./eip"
  eip_client = var.client
}


module "nat_gateway" {
  source = "./nat_gateway"

  nat_gateway_eip  = module.eip.eip_id1
  subnet_id_public = module.networks.subnet_id_public
  internet_gw      = module.networks.internet_gw
  nat_client       = var.client
}

module "iam_role" {
  source     = "./iam_role"
  iam_client = var.client

}

module "networks" {
  source = "./networks"

  networks_vpc_id = module.vpc.vpc_id
  networks_client = var.client
  networks_cidr   = module.vpc.vpc_cidr
  networks_region = var.region
  networks_zones  = var.availability_zone
  nat_zone_1      = module.nat_gateway.nat_zone_1
  iam_role_arn    = module.iam_role.app_iam_arn

}

module "s_group" {
  source = "./s_group"

  s_group_client    = var.client
  s_group_vpc_id    = module.vpc.vpc_id
  s_group_vpc_cidr  = module.vpc.vpc_cidr
  s_group_server_ip = var.server_ip
}


module "data_tier" {
  source              = "./data_tier"
  sg_id_data_tier     = module.s_group.sg_id_data_tier
  data_tier_client    = var.client
  subnet_id_private   = module.networks.subnet_id_private
  data_tier_vpc       = module.vpc.vpc_id
  private_key         = var.private_key
  pub_key             = var.pub_key
  key-pair            = module.networks.key-pair
  image               = var.image
  data_tier_node_type = var.data_tier_node_type


}


module "client_tier" {
  source             = "./client_tier"
  data_tier_ip       = module.data_tier.data_tier_private_ip
  client_tier_region = var.region
  client_tier_vpc    = module.vpc.vpc_id
  client_tier_client = var.client
  subnet_id_public   = module.networks.subnet_id_public
  client_tier_ak     = var.aws_access_key
  client_tier_sk     = var.aws_secret_key
  client_tier_sg     = module.s_group.sg_id_client_tier

  private_key           = var.private_key
  pub_key               = var.pub_key
  key-pair              = module.networks.key-pair
  image                 = var.image
  client_tier_eip       = module.eip.eip_id2
  client_tier_public_ip = module.eip.eip_address
  data_tier_sg_id       = module.s_group.sg_id_data_tier
  client_tier_node_type = var.client_tier_node_type
}
