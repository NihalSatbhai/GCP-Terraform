# Calling VM module with defined source along with required variables
# module "VM" {
#   source             = "../CustomModules/VM"
#   family             = var.family
#   family-project     = var.family-project
#   zone               = var.zone
#   machine-type       = var.machine-type
#   public-subnetwork  = module.VPC.public-subnet-name
#   private-subnetwork = module.VPC.private-subnet-name
#   ssh-user           = var.ssh-user
#   metadata-script    = templatefile("../CustomModules/Scripts/metadata-script.sh", {}) ## Make sure you update metadata-script.sh according to your requirements
# }