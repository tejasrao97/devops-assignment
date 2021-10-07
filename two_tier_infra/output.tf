output "vpc_id" {
  value = module.vpc.vpc_id
}


output "vpc_cidr" {
  value = module.vpc.vpc_cidr
}


output "sg_id_client_tier" {
  value = module.s_group.sg_id_client_tier
}

output "subnet_id_public" {
  value = module.networks.subnet_id_public
}

output "subnet_id_private" {
  value = module.networks.subnet_id_private
}


output "client_tier_eip" {
  value = module.eip.eip_address
}

