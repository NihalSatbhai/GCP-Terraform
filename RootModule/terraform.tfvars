## This file will contain the actual values for your declared variables
## WARNING = Never push this file to your public repository as it can contain some sensitive information

# General
project = "gcp-terraform-365916"
region  = "us-central1"

# VPC Module
app-public-subnet-cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
app-private-subnet-cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
db-private-subnet-cidrs  = ["10.0.5.0/24", "10.0.6.0/24"]
proxy-subnet-cidr        = "10.129.0.0/26"
public-firewall-ports    = ["22", "80", "443", "8080"]
private-firewall-ports   = ["22", "80", "443", "8080"]
db-firewall-ports        = ["22", "5432"]

# Compute Module
family         = "debian-11"
family-project = "debian-cloud"
zone           = "us-central1-a"
machine-type   = "e2-micro"
ssh-user       = "nihal"