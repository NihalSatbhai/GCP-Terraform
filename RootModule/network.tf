## Calling VPC module with defined source along with required variables
module "VPC" {
  source                   = "../CustomModules/VPC"
  project                  = var.project
  region                   = var.region
  app-public-subnet-cidrs  = var.app-public-subnet-cidrs
  app-private-subnet-cidrs = var.app-private-subnet-cidrs
  db-private-subnet-cidrs  = var.db-private-subnet-cidrs
  proxy-subnet-cidr        = var.proxy-subnet-cidr
  public-firewall-ports    = var.public-firewall-ports
  private-firewall-ports   = var.private-firewall-ports
  db-firewall-ports        = var.db-firewall-ports
}