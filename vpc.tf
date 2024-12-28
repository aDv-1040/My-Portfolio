resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "terraform-vpc"
    env  = "dev"
  }
}
resource "aws_subnet" "terraform-public-subnet1" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "terraform-public-subnet"
    env  = "dev"
  }
}
resource "aws_subnet" "terraform-public-subnet2" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "terraform-public-subnet"
    env  = "dev"
  }
}
resource "aws_subnet" "terraform-private-subnet1" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "terraform-private-subnet"
    env  = "dev"
  }
}
resource "aws_subnet" "terraform-private-subnet2" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "terraform-private-subnet"
    env  = "dev"
  }
}
resource "aws_internet_gateway" "my-gateway" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "internet-gateway"
    env  = "dev"
  }
}
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.terraform-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-gateway.id
  }

  tags = {
    Name = "public-rt"
    env  = "dev"
  }
}
resource "aws_eip" "random_eip" {
  domain = "vpc"
  }

resource "aws_nat_gateway" "ngw" {
  subnet_id     = aws_subnet.terraform-public-subnet1.id
  allocation_id = aws_eip.random_eip.id

  tags = {
    Name = "gw NAT"
    env  = "dev"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    name = "private-rt"
    env  = "dev"
  }
}
resource "aws_route_table_association" "my-association1" {
  subnet_id      = aws_subnet.terraform-public-subnet1.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "my-association2" {
  subnet_id      = aws_subnet.terraform-private-subnet1.id
  route_table_id = aws_route_table.private-rt.id
}
resource "aws_route_table_association" "my-association3" {
  subnet_id      = aws_subnet.terraform-public-subnet2.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "my-association4" {
  subnet_id      = aws_subnet.terraform-private-subnet2.id
  route_table_id = aws_route_table.private-rt.id
}
resource "aws_network_acl" "my-nacl" {
  vpc_id = aws_vpc.terraform-vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 443
    to_port    = 443
  }
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 80
    to_port    = 80
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 443
    to_port    = 443
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 80
    to_port    = 80
  }
  egress {
    protocol   = "tcp"
    rule_no    = 150
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 22
    to_port    = 22
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 150
    action     = "allow"
    cidr_block = "10.0.1.0/24"
    from_port  = 22
    to_port    = 22
  }
  tags = {
    Name = "my-nacl"
    env  = "dev"
  }
}
resource "aws_network_acl_association" "my-nacl-association1" {
  network_acl_id = aws_network_acl.my-nacl.id
  subnet_id      = aws_subnet.terraform-public-subnet1.id
}
resource "aws_network_acl_association" "my-nacl-association2" {
  network_acl_id = aws_network_acl.my-nacl.id
  subnet_id      = aws_subnet.terraform-private-subnet1.id
}
resource "aws_network_acl_association" "my-nacl-association3" {
  network_acl_id = aws_network_acl.my-nacl.id
  subnet_id      = aws_subnet.terraform-public-subnet2.id
}
resource "aws_network_acl_association" "my-nacl-association4" {
  network_acl_id = aws_network_acl.my-nacl.id
  subnet_id      = aws_subnet.terraform-private-subnet2.id
}
resource "aws_security_group" "my-sg" {
  name        = "allow_https_http_ssh"
  description = "Allow https,http & ssh inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.terraform-vpc.id

  tags = {
    Name = "allow_https_http_ssh"
    env  = "dev"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.my-sg.id
  cidr_ipv4         = aws_vpc.terraform-vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.my-sg.id
  cidr_ipv4         = aws_vpc.terraform-vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.my-sg.id
  cidr_ipv4         = aws_vpc.terraform-vpc.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_endpoint" "s3-endpoint" {
  vpc_id            = aws_vpc.terraform-vpc.id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"
  tags = {
    name = "s3-endpoint1"
    env  = "dev"
  }
}

resource "aws_vpc_endpoint_route_table_association" "s3-endpoint-association" {
  route_table_id  = aws_route_table.private-rt.id
  vpc_endpoint_id = aws_vpc_endpoint.s3-endpoint.id
}

resource "aws_lb" "backend-lb-tf" {
  name                       = "backend-lb-tf"
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.my-sg.id]
  subnets                    = [aws_subnet.terraform-private-subnet1.id, aws_subnet.terraform-private-subnet2.id]
  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}
resource "aws_lb_target_group" "target-group" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terraform-vpc.id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_launch_template" "my-template" {
  name = "my-template"
  image_id      = "ami-0166fe664262f664c"
  instance_type = "c5.large"
  key_name      = "firstkeypair"
  user_data     = filebase64("${path.module}/nginx-userdata.sh")
}

resource "aws_autoscaling_group" "my-asg" {
  desired_capacity    = 5
  min_size            = 3
  max_size            = 7
  vpc_zone_identifier = [aws_subnet.terraform-private-subnet1.id, aws_subnet.terraform-private-subnet2.id]

  launch_template {
    id      = aws_launch_template.my-template.id
    version = "$Latest"
  }
  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true
}


resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.backend-lb-tf.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}


  resource "aws_db_instance" "my-db" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "16.3"
  instance_class       = "db.t3.micro"
  username             = "adv"
  password             = "password123"
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  db_subnet_group_name = aws_db_subnet_group.db-subnet-group.name
  skip_final_snapshot = true
  tags = {
    Name = "postgres-db"
  }
}

resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.terraform-private-subnet1.id, aws_subnet.terraform-private-subnet2.id]

  tags = {
    Name = "db-subnet-group"
  }
}

resource "aws_security_group" "db-sg" {
  name        = "db-sg"
  description = "Allow database access from backend"
  vpc_id      = aws_vpc.terraform-vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Adjust to match back-end subnet range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}

resource "aws_lb" "frontend-lb" {
  name               = "frontend-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my-sg.id]
  subnets            = [aws_subnet.terraform-public-subnet1.id, aws_subnet.terraform-public-subnet2.id]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "frontend-target-group" {
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terraform-vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "frontend-target-group"
  }
}

resource "aws_launch_template" "frontend-template" {
  name          = "frontend-template"
  image_id      = "ami-0166fe664262f664c" # Update as needed
  instance_type = "t3.micro"
  key_name      = "firstkeypair"
  #user_data     = filebase64("${path.module}/frontend-userdata.sh")

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "frontend-instance"
    }
  }
}

resource "aws_autoscaling_group" "frontend-asg" {
  desired_capacity    = 3
  min_size            = 2
  max_size            = 5
  vpc_zone_identifier = [aws_subnet.terraform-public-subnet1.id, aws_subnet.terraform-public-subnet2.id]

  launch_template {
    id      = aws_launch_template.frontend-template.id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
  target_group_arns         = [aws_lb_target_group.frontend-target-group.arn]
}

resource "aws_lb_listener" "frontend-listener" {
  load_balancer_arn = aws_lb.frontend-lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend-target-group.arn
  }
}

output "frontend_alb_dns" {
  value = aws_lb.frontend-lb.dns_name
}

output "db_endpoint" {
  value = aws_db_instance.my-db.endpoint
}





