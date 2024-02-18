#create vpc 
module "vpc" {
  source = "./vpc"
}

module "bastion_host" {
  source           = "./bastion_host"
  public_subnet_id = module.vpc.public_subnet1
  vpc_id = module.vpc.main_vpc
  aws_iam_instance_profile = module.roles.role_profile
  user_data = filebase64("userdata.sh")
}

module "roles" {
  source = "./role"
}

module "security_group" {
  source = "./security_group"
  vpc_id = module.vpc.main_vpc
}

module "template" {
  source = "./template"
  ami = module.bastion_host.ami
  key_pair = module.bastion_host.key_pair
  vpc_id = module.vpc.main_vpc
  user_data = filebase64("userdata.sh")
  security_groups = [module.security_group.security_groups]
  private_subnet_id =  module.vpc.private_subnet1 # module.vpc.private_subnet
}

module "asg" {
  source = "./ASG"
  launch_template = module.template.launch_template
}

module "alb" {
  source = "./ALB"
  vpc_id = module.vpc.main_vpc
  security_groups = module.security_group.security_groups
  public_subnet1 = module.vpc.public_subnet1
  public_subnet2 = module.vpc.public_subnet2
  autoscaling_group_name = module.asg.main_asg
}

module "s3" {
  source = "./s3"
}

module "rds" {
  source = "./rds"
  subnet_groups = module.vpc.subnet_groups
  security_groups = module.security_group.security_groups
}
