# Create VPC
resource "aws_vpc" "PADEU2_VPC" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

#Create Pub SN 1
resource "aws_subnet" "PADEU2_Pub_SN1" {
  vpc_id            = aws_vpc.PADEU2_VPC.id
  cidr_block        = var.vpc_pub_sub1
  availability_zone = var.vpc_az1
  tags = {
    Name = "${var.name}-PubSN1"
  }
}
#Create Pub SN 2
resource "aws_subnet" "PADEU2_Pub_SN2" {
  vpc_id            = aws_vpc.PADEU2_VPC.id
  cidr_block        = var.vpc_pub_sub2
  availability_zone = var.vpc_az2
  tags = {
    Name = "${var.name}-PubSN2"
  }
}
#Create Priv SN 1
resource "aws_subnet" "PADEU2_Priv_SN1" {
  vpc_id            = aws_vpc.PADEU2_VPC.id
  cidr_block        = var.vpc_priv_sub1
  availability_zone = var.vpc_az1
  tags = {
    Name = "${var.name}-PrivSN1"
  }
}
#Create Priv Subnet 2
resource "aws_subnet" "PADEU2_Priv_SN2" {
  vpc_id            = aws_vpc.PADEU2_VPC.id
  cidr_block        = var.vpc_priv_sub2
  availability_zone = var.vpc_az2
  tags = {
    Name = "${var.name}-PrivSN2"
  }
}

#Create IGW
resource "aws_internet_gateway" "PADEU2_IGW" {
  vpc_id = aws_vpc.PADEU2_VPC.id
  tags = {
    Name = "${var.name}-IGW"
  }
}
#Create Elastic IP
resource "aws_eip" "PADEU2_EIP" {
  vpc = true
  tags = {
    Name = "${var.name}-EIP"
  }
}

#Create NGW
resource "aws_nat_gateway" "PADEU2_NGW" {
  subnet_id         = aws_subnet.PADEU2_Pub_SN1.id
  allocation_id = aws_eip.PADEU2_EIP.id

  tags = {
    Name = "${var.name}-NGW"
  }
}


#Create Public Route Table
resource "aws_route_table" "PADEU2_Pub_RTB" {
  vpc_id = aws_vpc.PADEU2_VPC.id

  route {
    cidr_block = var.all_access
    gateway_id = aws_internet_gateway.PADEU2_IGW.id
  }

  tags = {
    Name = "${var.name}-PubRT"
  }
}

#Create Private Route Table
resource "aws_route_table" "PADEU2_Priv_RTB" {
  vpc_id = aws_vpc.PADEU2_VPC.id

  route {
    cidr_block = var.all_access
    gateway_id = aws_nat_gateway.PADEU2_NGW.id
  }

  tags = {
    Name = "${var.name}-PrivRT"
  }
}

#Create Pub SN1 Association
resource "aws_route_table_association" "PADEU2_Pub_RTB_AS1" {
  subnet_id      = aws_subnet.PADEU2_Pub_SN1.id
  route_table_id = aws_route_table.PADEU2_Pub_RTB.id
}

#Create Pub SN2 Association
resource "aws_route_table_association" "PADEU2_Pubd_RTB_AS2" {
  subnet_id      = aws_subnet.PADEU2_Pub_SN2.id
  route_table_id = aws_route_table.PADEU2_Pub_RTB.id
}

#Create Priv SN1 Association
resource "aws_route_table_association" "PADEU2_Priv_RTB_AS1" {
  subnet_id      = aws_subnet.PADEU2_Priv_SN1.id
  route_table_id = aws_route_table.PADEU2_Priv_RTB.id
}

#Create Priv SN2 Association
resource "aws_route_table_association" "PADEU2_Priv_RTB_AS2" {
  subnet_id      = aws_subnet.PADEU2_Priv_SN2.id
  route_table_id = aws_route_table.PADEU2_Priv_RTB.id
}