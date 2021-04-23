resource "aws_subnet" "public" {
    vpc_id = var.vpc_id
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-2a"
    map_public_ip_on_launch = true

    tags = {
        Name = "production"
    }
}

resource "aws_subnet" "subnet-2" {
    vpc_id = var.vpc_id
    cidr_block = "10.0.2.0/24"
    availability_zone = "eu-west-2b"
    

    tags = {
        Name = "private-subnet1"
    }
}

resource "aws_subnet" "subnet-3" {
    vpc_id = var.vpc_id
    cidr_block = "10.0.3.0/24"
    availability_zone = "eu-west-2c"
    

    tags = {
        Name = "private-subnet2"
    }
}

resource "aws_db_subnet_group" "private_group" {
  name       = "private-group"
  subnet_ids = [aws_subnet.subnet-2.id, aws_subnet.subnet-3.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_route_table_association" "public_association" {
    subnet_id = aws_subnet.public.id
    route_table_id = var.route_id_prod
}

resource "aws_route_table_association" "b" {
    subnet_id = aws_subnet.subnet-2.id
    route_table_id = var.route_id_private
}

resource "aws_route_table_association" "c" {
    subnet_id = aws_subnet.subnet-3.id
    route_table_id = var.route_id_private
}


resource "aws_network_interface" "net_interface_jenkins" {
    subnet_id = aws_subnet.public.id
    private_ips = ["10.0.1.50"]
    security_groups = [var.security_id]
}

resource "aws_network_interface" "net_interface_prod" {
    subnet_id = aws_subnet.public.id
    private_ips = ["10.0.1.51"]
    security_groups = [var.security_id]
}

resource "aws_network_interface" "net_interface_test" {
    subnet_id = aws_subnet.public.id
    private_ips = ["10.0.1.52"]
    security_groups = [var.security_id]
}

resource "aws_eip" "eip1" {
    vpc = true
    depends_on = [var.internet_gate]
}

resource "aws_nat_gateway" "NAT_GATEWAY" {  
    depends_on = [    aws_eip.eip1  ]  
    allocation_id = aws_eip.eip1.id    
    subnet_id = aws_subnet.public.id  
    tags = {    
        Name = "Nat-Gateway-One"  
        }
}