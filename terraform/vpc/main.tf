resource "aws_vpc" "production" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "production"
    }
}

resource "aws_route_table" "prod_route" {
    vpc_id = aws_vpc.production.id 

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    route {
        ipv6_cidr_block = "::/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "production"
    }

} 

resource "aws_route_table" "private_route" {
    vpc_id = aws_vpc.production.id 

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = var.nat_gate_id
    }

    tags = {
        Name = "production"
    }

} 

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.production.id

    tags = {
        Name = "production"
    }
}

resource "aws_security_group" "allow_web" {
    name = "allow_web"
    description = "Allow web inbound traffic"
    vpc_id = aws_vpc.production.id
    
    ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "http traffic"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "http traffic"
        from_port = 2222
        to_port = 2222
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "http traffic"
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        description = "http traffic"
        from_port = 5001
        to_port = 5001
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "http traffic"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow_web_traffic"
    }
}

resource "aws_security_group" "allow_sql" {
    name = "allow_sql"
    description = "Allow web inbound traffic"
    vpc_id = aws_vpc.production.id
    ingress {
        description = "sql"
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.allow_web.id]
    }
    ingress {
        description = "ssh"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}