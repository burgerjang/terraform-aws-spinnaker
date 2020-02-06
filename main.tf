terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
}

module "vpc" {
  source             = "./modules/vpc"
  name               = "test-vpc"
  cidr               = "10.0.0.0/16"
	azs                  = data.aws_availability_zones.available.names
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  tags = {
		"test" = "shared"
  }
}


