output "vpc_id" {

    value = aws_vpc.production.id
  
}

output "route_id_prod" {

    value = aws_route_table.prod_route.id
  
}

output "route_id_private" {

    value = aws_route_table.private_route.id
  
}

output "security_id" {
    value = aws_security_group.allow_web.id
}

output "security_id_sql" {
    value = aws_security_group.allow_sql.id
}

output "internet_gate" {
    value = aws_internet_gateway.igw
}