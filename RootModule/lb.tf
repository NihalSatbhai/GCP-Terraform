## Calling LB module with defined source along with required variables
module "LB" {
  source       = "../CustomModules/LB"
  region       = var.region
  network      = module.VPC.vpc-id
  igm          = module.ASG.igm-instance-group
  health-check = module.ASG.health-check-id
  proxy-subnet = module.VPC.proxy-subnet-name
}