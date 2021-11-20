resource "aws_vpc" "vpc_SANDBOX" {
  cidr_block         = var.CIDR_BLOCK
  enable_dns_support = "true" #gives you an internal domain name
  instance_tenancy   = "default"

  tags = {
    Name        = "vpc-SANDBOX-dev"
    Environment = "${var.ENV}"
  }
}

//AZ - A
resource "aws_subnet" "public-subnet-a" {
  vpc_id                  = aws_vpc.vpc_SANDBOX.id
  cidr_block              = var.CIDR_BLOCK_PUB_A
  map_public_ip_on_launch = "true" # make this subnet public
  availability_zone       = var.AZ_A

  tags = {
    Name        = "public-subnet-a"
    Environment = "${var.ENV}"
  }
}

resource "aws_subnet" "private-subnet-a" {
  vpc_id            = aws_vpc.vpc_SANDBOX.id
  cidr_block        = var.CIDR_BLOCK_PVT_A
  availability_zone = var.AZ_A

  tags = {
    Name        = "private-subnet-a"
    Environment = "${var.ENV}"
  }
}

//AZ - B
resource "aws_subnet" "public-subnet-b" {
  vpc_id                  = aws_vpc.vpc_SANDBOX.id
  cidr_block              = var.CIDR_BLOCK_PUB_B
  map_public_ip_on_launch = "true" # make this subnet public
  availability_zone       = var.AZ_B

  tags = {
    Name        = "public-subnet-b"
    Environment = "${var.ENV}"
  }
}

resource "aws_subnet" "private-subnet-b" {
  vpc_id            = aws_vpc.vpc_SANDBOX.id
  cidr_block        = var.CIDR_BLOCK_PVT_B
  availability_zone = var.AZ_B

  tags = {
    Name        = "private-subnet-b"
    Environment = "${var.ENV}"
  }
}

//AZ - C
resource "aws_subnet" "public-subnet-c" {
  vpc_id                  = aws_vpc.vpc_SANDBOX.id
  cidr_block              = var.CIDR_BLOCK_PUB_C
  map_public_ip_on_launch = "true" # make this subnet public
  availability_zone       = var.AZ_C

  tags = {
    Name        = "public-subnet-c"
    Environment = "${var.ENV}"
  }
}

resource "aws_subnet" "private-subnet-c" {
  vpc_id            = aws_vpc.vpc_SANDBOX.id
  cidr_block        = var.CIDR_BLOCK_PVT_C
  availability_zone = var.AZ_C

  tags = {
    Name        = "private-subnet-c"
   Environment = "${var.ENV}"
  }
}

