# VPC Configuration
vpc_cidr_block = "10.0.0.0/16"
# Subnet Configuration
subnet_cidr_blocks = {
  public1  = "10.0.1.0/24"
  private1 = "10.0.2.0/24"
  public2  = "10.0.3.0/24"
  private2 = "10.0.4.0/24"
}
availability_zones = [ "us-east-1a","us-east-1b" ]

# # Security Groups
# security_group_name = "allow_https_http_ssh"
# security_group_description = "Allow https, http & ssh inbound traffic and all outbound traffic"
# security_group_tags = {
#   Name = "allow_https_http_ssh"
#   env  = "dev"
# }

# # Load Balancer
# frontend_lb_name = "frontend-lb-tf"
# frontend_lb_internal = false
# frontend_lb_tags = {
#   Environment = "production"
# }
# frontend_target_group_name = "frontend-target-group"

# backend_lb_name = "backend-lb-tf"
# backend_lb_internal = true
# backend_lb_tags = {
#   Environment = "production"
# }
# backend_target_group_name = "backend-target-group"

# # AutoScaling Group
# frontend_asg_min_size = 2
# frontend_asg_max_size = 5
# frontend_asg_desired_capacity = 3
# backend_asg_min_size = 3
# backend_asg_max_size = 7
# backend_asg_desired_capacity = 5

# # Database Configuration
# db_name = "postgres-db"
# db_engine = "postgres"
# db_engine_version = "16.3"
# db_instance_class = "db.t3.micro"
# db_allocated_storage = 20
# db_username = "adv"
# db_password = "password123" # Change this to a secure password
# db_tags = {
#   Name = "postgres-db"
# }
# db_subnet_group_name = "db-subnet-group"

# # Key Pair
# key_name = "firstkeypair"

# # AMI IDs
# frontend_ami_id = "ami-0166fe664262f664c" # Replace with a valid AMI ID for your region
# backend_ami_id = "ami-0166fe664262f664c" # Replace with a valid AMI ID for your region
