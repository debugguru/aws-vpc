resource "aws_internet_gateway" "igw_SANDBOX" {
  vpc_id = aws_vpc.vpc_SANDBOX.id

  tags = {
    Name        = "igw_SANDBOX"
    Environment = "${var.ENV}"
  }
}

//public route table
resource "aws_route_table" "route-public" {
  vpc_id = aws_vpc.vpc_SANDBOX.id
  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.igw_SANDBOX.id
  }

  tags = {
    Name        = "route-public"
    Environment = "${var.ENV}"
  }
}

//associate public subnets to public routes
resource "aws_route_table_association" "route-public-subnet-a" {
  subnet_id      = aws_subnet.public-subnet-a.id
  route_table_id = aws_route_table.route-public.id
}

resource "aws_route_table_association" "route-public-subnet-b" {
  subnet_id      = aws_subnet.public-subnet-b.id
  route_table_id = aws_route_table.route-public.id
}

resource "aws_route_table_association" "route-public-subnet-c" {
  subnet_id      = aws_subnet.public-subnet-c.id
  route_table_id = aws_route_table.route-public.id
}


//public route table
resource "aws_route_table" "route-private" {
  vpc_id = aws_vpc.vpc_SANDBOX.id

  tags = {
    Name        = "route-private"
    Environment = "${var.ENV}"
  }
}

//associate private subnets to private routes
resource "aws_route_table_association" "route-private-subnet-a" {
  subnet_id      = aws_subnet.private-subnet-a.id
  route_table_id = aws_route_table.route-private.id
}

resource "aws_route_table_association" "route-private-subnet-b" {
  subnet_id      = aws_subnet.private-subnet-b.id
  route_table_id = aws_route_table.route-private.id
}

resource "aws_route_table_association" "route-private-subnet-c" {
  subnet_id      = aws_subnet.private-subnet-c.id
  route_table_id = aws_route_table.route-private.id
}

//network acl
resource "aws_network_acl" "acl-SANDBOX" {
  vpc_id = aws_vpc.vpc_SANDBOX.id
  
  subnet_ids = [
    aws_subnet.public-subnet-a.id,
    aws_subnet.public-subnet-b.id,
    aws_subnet.public-subnet-c.id
  ]

  egress {
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "all"
    rule_no    = 100
    from_port  = "0"
    to_port    = "0"
  }

  egress {
    action          = "allow"
    ipv6_cidr_block = "::/0"
    protocol        = "all"
    rule_no         = 101
    from_port       = "0"
    to_port         = "0"
  }

  ingress {
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "all"
    rule_no    = 100
    from_port  = "0"
    to_port    = "0"
  }

  ingress {
    action          = "allow"
    ipv6_cidr_block = "::/0"
    protocol        = "all"
    rule_no         = 101
    from_port       = "0"
    to_port         = "0"
  }

  tags = {
    Name        = "acl-SANDBOX-dev"
    Environment = "${var.ENV}"
  }
}


//security groups
resource "aws_security_group" "WebServerSG" {
  name        = "WebServerSG"
  description = "Security group for instance in public Subnet"
  vpc_id      = aws_vpc.vpc_SANDBOX.id

  ingress {
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
  }
  ingress {
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
  }

  egress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.DatabaseSG.id]
  }

  tags = {
    Name        = "WebServerSG"
    Environment = "${var.ENV}"
  }
}

resource "aws_security_group" "DatabaseSG" {
  name        = "DatabaseSG"
  description = "Security Group for DB Instance in Private SG"
  vpc_id      = aws_vpc.vpc_SANDBOX.id

  tags = {
    Name        = "DatabaseSG"
    Environment = "${var.ENV}"
  }
}
//creating this as seperate rule instead of inside above SG 
//as it create cyclic dependency which terraform does not allow
//https://stackoverflow.com/questions/38246326/cycle-error-when-trying-to-create-aws-vpc-security-groups-using-terraform

resource "aws_security_group_rule" "rl_web_server" {
  description              = "Database connection only allowed from Public subnet"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.DatabaseSG.id
  source_security_group_id = aws_security_group.WebServerSG.id
}


