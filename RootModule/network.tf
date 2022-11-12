## Calling VPC module with defined source along with required variables
module "VPC" {
  source                    = "../CustomModules/VPC"
  project                   = var.project
  region                    = var.region
  app-public-subnet1-cidr   = var.app-public-subnet1-cidr
  app-public-subnet2-cidr   = var.app-public-subnet2-cidr
  app-private-subnet1-cidr  = var.app-private-subnet1-cidr
  app-private-subnet2-cidr  = var.app-private-subnet2-cidr
  db-private-subnet1-cidr   = var.db-private-subnet1-cidr
  db-private-subnet2-cidr   = var.db-private-subnet2-cidr
  public-firewall-ports     = var.public-firewall-ports
  private-firewall-ports    = var.private-firewall-ports
  db-firewall-ports         = var.db-firewall-ports
}