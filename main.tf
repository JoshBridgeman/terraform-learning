provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "app-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

module "app-subnet" {
  source = "./modules/subnet"
  subnet_cidr_block = var.subnet_cidr_block
  vpc_id = aws_vpc.app-vpc.id
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix
  default_route_table_id = aws_vpc.app-vpc.default_route_table_id
}

module "app-server" {
  source = "./modules/webserver"
  vpc_id = aws_vpc.app-vpc.id
  access_ip = var.access_ip
  env_prefix = var.env_prefix
  img_name = var.img_name
  pub-key-location = var.pub-key-location
  instance_type = var.instance_type
  subnet_id = module.app-subnet.subnet.id
  avail_zone = var.avail_zone
}