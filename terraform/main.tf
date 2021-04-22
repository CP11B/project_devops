provider "aws" {
  region = "eu-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
    source = "./vpc"

    nat_gate_id = module.subnets.nat_gate_id
    #db_group_name = module.subnets.db_group_name
    #security_id_sql = module.vpc.security_id_sql
  
}

module "subnets" {
    source = "./subnets"

    vpc_id = module.vpc.vpc_id
    route_id_prod = module.vpc.route_id_prod
    route_id_private = module.vpc.route_id_private
    security_id = module.vpc.security_id
    internet_gate = module.vpc.internet_gate
  
}

module "ec2" {
    source = "./ec2"

    network_int_id_jenkins = module.subnets.network_int_id_jenkins
    network_int_id_prod = module.subnets.network_int_id_prod
    network_int_id_test = module.subnets.network_int_id_test
    #db_group_id = module.subnets.db_group_id
    db_group_name = module.subnets.db_group_name
    security_id_sql = module.vpc.security_id_sql

    ami_id = "ami-096cb92bb3580c759"
    instance_size = "t2.small"
    avail_zone = "eu-west-2a"
    ssh_key_name = "aws-ssh"
    db_password = var.db_password
  
}

resource "local_file" "tf_ips" {
  filename = "tf_ips"
  content = <<-DOC
    [jenkins]
    ${module.ec2.jenkins_ip} 
    [production]
    ${module.ec2.production_ip} 
    [test]
    ${module.ec2.test_ip} 
    
    DOC
}