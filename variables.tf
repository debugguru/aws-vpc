variable "AWS_REGION" {
  default = "us-east-1"
}

//cidr range
variable "CIDR_BLOCK" {
  default = "10.0.0.0/16"
}

variable "CIDR_BLOCK_PUB_A" {
  default = "10.0.0.0/21"
}

variable "CIDR_BLOCK_PVT_A" {
  default = "10.0.8.0/21"
}

variable "CIDR_BLOCK_PUB_B" {
  default = "10.0.16.0/21"
}

variable "CIDR_BLOCK_PVT_B" {
  default = "10.0.24.0/21"
}

variable "CIDR_BLOCK_PUB_C" {
  default = "10.0.32.0/21"
}

//AZs
variable "CIDR_BLOCK_PVT_C" {
  default = "10.0.40.0/21"
}


variable "AZ_A" {
  default = "us-east-1a"
}

variable "AZ_B" {
  default = "us-east-1b"
}

variable "AZ_C" {
  default = "us-east-1c"
}

//tags
variable "ENV" {
  default = "SANDBOX"
}

variable "COMPANY" {
  default = "Unicorn"
}

