# Terraform Block

terraform {
  required_version = "~> 1.2"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.2"
     }
  }
}

# Provider Block

provider "aws" {
    region = var.aws_region
    profile = "default"
  
}

# Variable Block

variable "aws_region" {
    description = "aws region"
    type = string
    default = "us-east-1"
  
}



# Create A VPC Module Template module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.3"
# Basic VPC Details

    name = "vpc-dev"
    cidr = "10.0.0.0/16"

    azs             = ["us-east-1a", "us-east-1b", ]
    private_subnets = ["10.0.1.0/24" , "10.0.2.0/24"]
    public_subnets  = ["10.0.101.0/24" , "10.0.102.0/24"]
   
   # data base subnet 
    create_database_subnet_group = true
    create_database_subnet_route_table = true

   database_subnets = ["10.0.151.0/24" , "10.0.152.0/24"]

    #create_database_nat_gateway_route = true
    # create_database_internet_gateway_route = true
  default_vpc_enable_dns_support  = true
#create_databsecreate_database_internet_gateway_route = true
#create_database__natcreate_database_nat_gateway_route = true
  enable_nat_gateway = true
  single_nat_gateway = true

# VPC DNS Parameters
enable_dns_hostnames = true
enable_dns_support = true


# 
   public_subnet_tags = {
    Name = "public-Subnets"
   } 

   private_subnet_tags  = {
    Name= "private_subnets"
   }

   database_subnet_tags = {
    Name = "database-subnets"
   }

   tags = {
    Owner = "Narendra"
    Envirnoment = "dev"
   }
   vpc_tags = {
    Name = "vpc_dev"
   }

}

/*
name = "vpc-dev"
cidr = "10.0.0.0/16
azs = ["us-east-1a" , "us-east-1b"]
private_subnets = ["10.0.0.0"] */