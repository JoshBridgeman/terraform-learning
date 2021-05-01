terraform {
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 3.0"
      }
  }
}

provider "aws" {
  region = "eu-west-2"
}

variable "cidr_blocks" {
    description = "Subnet CIDR Blocks for vpc and subnets"
    type = list(object({
      cidr_block = string
      name = string
    }
    ))
}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.cidr_blocks[0].cidr_block

  tags = {
      Name = var.cidr_blocks[0].name

  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.cidr_blocks[1].cidr_block
  availability_zone = "eu-west-2a"

  tags = {
      Name = var.cidr_blocks[1].name
  }
}

#Geting data for creation according to pre-existing resources
data "aws_vpc" "existing-vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.existing-vpc.id
  cidr_block = "172.31.48.0/20"
  availability_zone = "eu-west-2a"

  tags = {
      Name = "dev-subnet-2"
  }
}

output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
}

output "dev-subnet-name" {
  value = aws_subnet.dev-subnet-1.tags["Name"]
}

output "dev-subnet-1-id" {
    value = aws_subnet.dev-subnet-1.id
}