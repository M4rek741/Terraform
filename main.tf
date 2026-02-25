#>Terraform Basics
#Generate a random string.
#resource "random_string" "random"{
#  length = 10
#}

#Terraform Resource Block template:

#REMINDER !
#Terraform Resource Block is used to manage ANY infrastructure (EC2/S3_Bucket/Whatever) we want to debloy on AWS.

# resource <BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
# Block body
# <IDENTIFIER> = <EXPRESSION> # Argument
# }

#Input Variable template:
#variable "<VARIABLE_NAME>" {
# #Block body
# type = <VARIABLE TYPE>
# description = <DESCRIPTION>
# default = <EXPRESSION>
# sensitive = <BOOLEAN>
# validation = <RULES>
#}


#WORKING CODE:

# Configure the AWS Provider
provider "aws" {
  #  access_key = "_NULL_"
  #  secret_key = "_NULL_"
  region                   = "us-east-1"
  shared_credentials_files = ["/root/TERRAFORM/.aws/credentials"]
}

# Create an EC2 instance called “web”.
resource "aws_instance" "web" {
  ami                    = "ami-0c1fe732b5494dc14"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-0561a24c2667c679b"
  vpc_security_group_ids = ["sg-04fc0cf9ea5598a43"]

  tags = {
    Terraform = "True"
    Purpose   = "Hashi Corp configuration language Lab"
  }
}

# Add a new resource - "VPC"
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name      = var.vpc_name
    Terraform = "true"
    Region    = data.aws_region.current.name
  }
}

data "aws_region" "current" {}

# Add a new resource - "Internet gateway"
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

# Add a new resource - "Route Table"
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name      = "demo_igw"
    Terraform = "true"
  }
}

# Add a new resource - "S3 bucket"
resource "aws_s3_bucket" "my-new-S3-bucket" {
  bucket = "my-new-Test-bucket-Marek"
  tags = {
    Name    = "My S3 Bucket"
    Purpose = "Intro to Resource Blocks Lab"
  }
}

# Add a new resource (an ACL) - "S3 bucket ACL"
# resource "aws_s3_bucket_acl" "my-new-acl-bucket" {
#  bucket = "aws_s3_bucket.my-new-S3-bucket.id"
#  acl    = "private"
# }


# Add a new resource block WITH variables - insted of hard coded values.
resource "aws_subnet" "terraform-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.variable_sub_cidr
  availability_zone       = var.variable_sub_az
  map_public_ip_on_launch = var.variable_sub_auto_ip

  tags = {
    Name      = "sub-variables-${var.variable_sub_az}"
    Terraform = "true"
  }
}