variable "vpc_app" {
  type        = string
  description = "This is for App server VPC"
}

variable "app_subnet" {
  type        = list(string)
  default     = ["app1","app2"]
  description = "This is for App Server VPC subnet"
}

variable "subnet_azs" {
  type        = list(string)
  description = "this is the availibity Zones of subnets"
}

variable "app_sg_config" {
  type = object({
    name        = string
    description = string
    rules = list(object({
      type       = string
      to_port    = number
      from_port  = number
      protocol   = string
      cidr_block = string
    }))

  })
  description = "This is for appserver security group"
}


# This is Ec2 Instance of App server

variable "app_subnet_names" {
  type        = string
  default     = "app1"
  description = "This is for Ec2 of App server"
}

variable "public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "ubuntu_ami_id" {
  type    = string
  default = "ami-0f8e81a3da6e2510a"
}

variable "app_ec2_size" {
  type    = string
  default = "t2.large"
}

variable "private_key_path" {
  type    = string
  default = "~/.ssh/id_rsa"

}

variable "app_script_version" {
  type    = string
  default = "0"

}

