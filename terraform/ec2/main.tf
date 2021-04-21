resource "aws_instance" "jenkins" {
    ami = var.ami_id
    instance_type = var.instance_size
    availability_zone = var.avail_zone
    key_name = var.ssh_key_name


    network_interface {
        network_interface_id = var.network_int_id_jenkins
        device_index = 0
    }

    tags = {
        Name = "jenkins"
    }
}

resource "aws_instance" "production" {
    ami = var.ami_id
    instance_type = var.instance_size
    availability_zone = var.avail_zone
    key_name = var.ssh_key_name


    network_interface {
        network_interface_id = var.network_int_id_prod
        device_index = 0
    }

    tags = {
        Name = "production"
    }
}

resource "aws_instance" "test" {
    ami = var.ami_id
    instance_type = var.instance_size
    availability_zone = var.avail_zone
    key_name = var.ssh_key_name


    network_interface {
        network_interface_id = var.network_int_id_test
        device_index = 0
    }

    tags = {
        Name = "test"
    }
}

resource "aws_db_instance" "default" {
    identifier = "testdb"
    allocated_storage    = 10
    db_subnet_group_name = var.db_group_name
    vpc_security_group_ids = [var.security_id_sql]
    engine               = "mysql"
    engine_version       = "8.0.20"
    instance_class       = "db.t3.micro"
    name                 = "mydb"
    username             = "admin"
    password             = var.db_password
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot  = true
    publicly_accessible  = false
}