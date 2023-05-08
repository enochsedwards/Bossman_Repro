#provider variable
variable "region" {
  default     = "eu-west-2"
  description = "AWS Region"
}

#VPC resource naming
variable "MainInfrastructure" {
  default     = "Bossman"
  description = "Naming convention for all resources"
}

variable "MainInfrastructure2" {
  default     = "BSMN"
  description = "Naming convention for route tables and gateways"
}

#VPC Cidr Allocation
variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "This is the VPC CIDR Block"
}

# Public subnet 1
variable "public_subnet_1" {
  default     = "10.0.10.0/24"
  description = "This is the Public Subnet 1 CIDR Block"
}

# Public subnet 1 AZ 
variable "az_1_name" {
  default     = "eu-west-2a"
  description = "This is the Availability Zone 1 name"
}

# Public subnet 2
variable "public_subnet_2" {
  default     = "10.0.11.0/24"
  description = "This is the Public Subnet 2 CIDR Block"
}

# Public subnet 2 AZ 
variable "az_2_name" {
  default     = "eu-west-2b"
  description = "This is the Availability Zone 2 name"
}

# Private subnet 1
variable "private_subnet_1" {
  default     = "10.0.12.0/24"
  description = "This is the Private Subnet 1 CIDR Block"
}

# Private subnet 1 AZ 
variable "az_c_name" {
  default     = "eu-west-2a"
  description = "This is the Availability Zone 1 name"
}


# Private subnet 2
variable "private_subnet_2" {
  default     = "10.0.13.0/24"
  description = "This is the Private Subnet 2 CIDR Block"
}

# Private subnet 2 AZ 
variable "az_3_name" {
  default     = "eu-west-2c"
  description = "This is the Availability Zone 3 name"
}