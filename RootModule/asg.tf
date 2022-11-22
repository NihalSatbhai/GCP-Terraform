## Calling ASG module with defined source along with required variables
module "ASG" {
  source             = "../CustomModules/ASG"
  family             = var.family
  family-project     = var.family-project
  zone               = var.zone
  machine-type       = var.machine-type
  private-subnetwork = module.VPC.private-subnet-name
  ssh-user           = var.ssh-user
  metadata-script    = templatefile("../CustomModules/Scripts/metadata-script.sh", {}) ## Make sure you update metadata-script.sh according to your requirements
}