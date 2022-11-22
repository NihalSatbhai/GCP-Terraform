## Calling output values from custom modules which will being used in root module
output "vpc-id" {
  value = module.VPC.vpc-id
}

output "private-subnet-name" {
  value = module.VPC.private-subnet-name
}

output "public-subnet-name" {
  value = module.VPC.public-subnet-name
}

output "proxy-subnet-name" {
  value = module.VPC.proxy-subnet-name
}

output "igm-instance-group" {
  value = module.ASG.igm-instance-group
}

output "health-check-id" {
  value = module.ASG.health-check-id
}