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


#WORKING CODE:

#Configure the AWS Provider
provider "aws" {
 #  access_key = "_NULL_"
 #  secret_key = "_NULL_"
   region = "us-east-1"
   shared_credentials_files = ["/root/TERRAFORM/.aws/credentials"]
 }

resource "aws_instance" "web" {
    ami		 	        = "ami-0c1fe732b5494dc14"
    instance_type		= "t3.micro"
    subnet_id			= "subnet-0561a24c2667c679b"
    vpc_security_group_ids	= ["sg-04fc0cf9ea5598a43"]

    tags = {
        Terraform = "True"
        Purpose = "Hashi Corp configuration language Lab"
    }
}

# resource "aws_s3_bucket" "my-new-S3-bucket" {
#  bucket = "my-new-Test-bucket-Marek"
#   tags = {
#     Name    = "My S3 Bucket"
#     Purpose = "Intro to Resource Blocks Lab"
#	}
# }



# resource "aws_s3_bucket_acl" "my-new-acl-bucket" {
#  bucket = "aws_s3_bucket.my-new-S3-bucket.id"
#  acl    = "private"
# }




#TRASH:
#resource "aws_s3_bucket" "my_new_S3_bucket" {
#    bucket = "my-new-tf-test-bucket-marek"
#    acl    = "private"

#    tags = {
#        Name = "My S3 Bucket"
#        Purpose = "Intor to Resource Block Lab"
#    }
#}

#resource "aws_s3_bucket_acl" "my_new_bucket_acl"{
#    bucket = aws_s3_bucket.my_new_S3_bucket.id
#    acl    = "private" 
#}

#Task: Add new provider.
#resource "random_id" "randomness_name_just_for_terminal"{
#    byte_length = 16
#}
