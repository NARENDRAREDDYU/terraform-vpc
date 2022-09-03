# VPC Variable
vpc_name = "myvpc"
cidr = "10.0.0.0/16"
vpc_availability_zones = [ "us-east-1a" , "us-east-1b" ]
public_subnets = [ "10.0.1.0/24" , "10.0.2.0/24" ]
private_subnets = [ "10.0.3.0/24" , "10.0.4.0/24" ]
database_subnets = [ "10.0.5.0/24" , "10.0.6.0/24" ]
create_database_subnet_group = true
create_database_subnet_route_table = true
enable_nat_gateway = true
single_nat_gateway = true