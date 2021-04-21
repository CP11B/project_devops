output "network_int_id_jenkins" {
    value = aws_network_interface.net_interface_jenkins.id

}

output "network_int_id_prod" {
    value = aws_network_interface.net_interface_prod.id

}

output "network_int_id_test" {
    value = aws_network_interface.net_interface_test.id

}

output "nat_gate_id" {
    value = aws_nat_gateway.NAT_GATEWAY.id
  
}

output "db_group_name" {
    value = aws_db_subnet_group.private_group.name
}