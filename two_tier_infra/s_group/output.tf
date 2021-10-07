output "sg_id_client_tier" {
  value = aws_security_group.client_tier.id
}

output "sg_id_data_tier" {
  value = aws_security_group.data_tier.id
}

