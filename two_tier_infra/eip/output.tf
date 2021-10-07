output "eip_id2" {
  value = aws_eip.client_tier.id
}

output "eip_id1" {
  value = aws_eip.nat.id
}


output "eip_address" {
  value = aws_eip.client_tier.public_ip
}
