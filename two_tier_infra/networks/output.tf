output "subnet_id_public" {
  value = aws_subnet.public.id
}

output "subnet_id_private" {
  value = aws_subnet.private.id
}


output "internet_gw" {
  value = aws_internet_gateway.internet_gw.id
}

output "key-pair" {
  value = aws_key_pair.app-keypair.key_name
}
