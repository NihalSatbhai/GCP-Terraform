## Calling Compute module with defined source along with required variables
module "Compute" {
  source = "../CustomModules/Compute"
  family = var.family
  family-project = var.family-project
  zone = var.zone
  machine-type = var.machine-type
  subnetwork = module.VPC.public-subnet1-name
  ssh-user = var.ssh-user
  metadata-script = templatefile("../CustomModules/Scripts/metadata-script.sh",{}) ## Make sure you update metadata-script.sh according to your requirements
}