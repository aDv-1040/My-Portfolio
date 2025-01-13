# variables.tf

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "tags" {
  description = "Tags to assign to resources"
  type        = map(string)
  default     = {
    Name = "dev-vpc"
  }
}

variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]  
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for the subnets"
  type        = map(string)
  default     = {
    public1  = "10.0.1.0/24"
    private1  = "10.0.2.0/24"
    public2 = "10.0.3.0/24"
    private2 = "10.0.4.0/24"
}
}

# variable "internet_gateway_name" {
#   description = "Name of the internet gateway"
#   type        = string
#   default = "my-gateway"
# }

variable "public_rt_name" {
  description = "Name of the public route table"
  type        = string
  default = "public-rt"
}

variable "private_rt_name" {
  description = "Name of the private route table"
  type        = string
  default = "private-rt"
}

# variable "nat_gateway_subnet" {
#   description = "Subnet ID for the NAT gateway"
#   type        = string
#   default = "ngw"
# }

# variable "eip_domain" {
#   description = "Domain for the Elastic IP"
#   type        = string
#   default = "randon_eip"
# }

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
  default = "my-sg"
}

variable "from_port" {
  description = "Starting port for the security group rule"
  type        = list(number)
  default     = [22, 80, 443]   
}

variable "to_port" {
  description = "Ending port for the security group rule"
  type        = list(number)
  default     = [22, 80, 443]   
}

variable "db_instance_username" {
  description = "Username for the database instance"
  type        = string
  default = "adv"
}

variable "path" {
  description = "target group path"
  type = string
  default = "/health"
}

variable "interval" {
  description = "target group interval"
  type = number
  default = 30
}
variable "timeout" {
  description = "target group timeout"
  type = number
  default = 5
}      
variable "healthy_threshold" {
  description = "target group healthy threshold"
  type = number
  default = 2
}

variable "unhealthy_threshold" {
  description = "target group unhealthy threshold"
  type = number
  default = 2
}

variable "image_id" {
  type = string
  description = "AMI ID for the template instances"
  default = "ami-0b5eea76982371e91"
}

variable "instance_type" {
  type = string
  description = "Instance type for the template instances"
  default = "c5.large"
}

variable "key_name" {
  type = string
  description = "Key name for the template instances"
  default = "firstkeypair"
}

variable "min_size" {
  type = number
  description = "Minimum size for the ASG"
  default = 3
}

variable "max_size" {
  type = number
  description = "Maximum size for the ASG"
  default = 7   
}

variable "desired_capacity" {
  type = number
  description = "Desired capacity for the ASG"
  default = 5
}

variable "health_check_type" {
  type = string
  description = "Health check type for the ASG"
  default = "EC2"
}
variable "health_check_grace_period" {
  type = number
  description = "Health check grace period for the ASG"
  default = 300
}

variable "force_delete" {
  type = bool
  description = "Force delete for the ASG"
  default = true
}

variable "db_instance_password" {
  description = "Password for the database instance"
  type        = string
  sensitive   = true
  default = "password123"
}
variable "allocated_storage" {
 type = number
 description = "Storage allocation for the database"
 default = 20
}
variable "db_engine" {
  type = string
  description = "Engine type for the database"
  default = "postgres"
}
variable "db_engine_version" {
  type = string
  description = "Engine version for the database"
  default = "16.3"
}  

variable "db_instance_class" {
  type = string
  description = "Instance class for the database"
  default = "db.t3.micro"
}

variable "frontend_template_image_id" {
  description = "AMI ID for the frontend instances"
  type        = string
  default     = "ami-0b5eea76982371e91"
}

variable "frontend_instance_type" {
  description = "Instance type for the frontend instances"
  type        = string
  default     = "t3.micro"
}

variable "frontend_min_size" {
  description = "Minimum size of the frontend autoscaling group"
  type        = number
  default     = 2
}


variable "frontend_max_size" {
  description = "Maximum size of the frontend autoscaling group"
  type        = number
  default     = 5
}

variable "frontend_desired_capacity" {
  description = "Desired capacity of the frontend autoscaling group"
  type        = number
  default     = 3
}

variable "frontend_target_group_name" {
  description = "Name of the frontend target group"
  type        = string
}
