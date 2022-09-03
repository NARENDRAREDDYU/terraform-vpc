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


# Input Variables Generic Variables
variable "aws_region" {
    description = "AWS Region "
    type = string
    default = "us-east-1"
}

variable "environment" {
    description = "Environment for business"
    type = string
    default = "dev"
}

variable "business_divsion" {
    description = "business_division"
    type = string
    default = "SAP"
}


# VPC Module block making every thing from variable

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.3"
  name = "${local.name}-${var.vpc_name}"
  cidr = var.cidr
  azs = var.vpc_availability_zones
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets

  # Data base Subnets

  database_subnets = var.database_subnets

  create_database_subnet_group = var.create_database_subnet_group
  create_database_subnet_route_table = var.create_database_subnet_route_table
 
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  public_subnet_tags = {
    type = "public_subnets"
  }

  private_subnet_tags = {
    type = "private_subnets"
  }

  database_subnet_tags = {
    type = "database_subnets"
  }

  tags = {
    Owner = "Narendra"
    Envirnoment = "dev"
  }
  
  vpc_tags = {
    name = "vpc-dev"
  }
}


# Local Values
locals {
  owners = var.business_divsion
  environment = var.environment
  name = "${local.owners}- ${local.environment}"
  common_tags = {
    owners = local.owners
    envirnoment = local.environment
  }

}

# VPC Variables 

variable "vpc_name" {
    description = "VPC NAME"
    type = string
    default = "vpc-dev"
}

variable "cidr" {
    description = "vpc cidr block"
    type = string
    default = "10.0.0.0/16"
}



variable "vpc_availability_zones" {
    description = "VPC Avaialability ZOnes"
    type = list(string)
    default = ["us-east-1a" , "us-east-1b"]
}


variable "public_subnets" {
    description = "VPC Public Subnets"
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
    description = "VPC Private Subnets"
    type = list(string)
    default = [ "10.0.3.0/24 , 10.0.4.0/24" ]
}

variable "database_subnets" {
    description = "database_subnets"
    type = list(string)
    default = [ "10.0.5.0/24" , "10.0.6.0/24" ]
}

variable "create_database_subnet_group" {
    description = "create database subnet group is a boolean option "
    type = bool
    default = true
}

variable "create_database_subnet_route_table" {
    description = "create_database_subnet_route_table"
    type = bool
    default = true
}

variable "enable_dns_hostnames" {
    description = "enable_dns_hostnames"
    type = bool
    default = true
}

variable "enable_dns_support" {
    description = "enable_dns_support"
    type = bool
    default = true
}

variable "enable_nat_gateway" {
    description = "enable_nat_gateway and connect with private subnet"
    type = bool
    default = true
}

variable "single_nat_gateway" {
    description = "single_nat_gateway"
    type = bool
    default = true
}



