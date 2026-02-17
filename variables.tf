variable "variable_sub_cidr" {
  description	= "CIDR block for the Variable Subnet"
  type		= string
}

variable "variable_sub_az" {
  description	= "Availability Zone used Variables Subnet"
  type		= string
}

variable "variable_sub_auto_ip" {
  description	= "Set Automatic IP Assignement for Variables Subnet"
  type		= bool
}
