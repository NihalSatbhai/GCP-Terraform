#################### Custom VPC ####################

resource "google_compute_network" "custom-vpc-network" {
  project                 = var.project
  name                    = "custom-vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1460 ## Maximun Transmission Unit in Bytes (Max Value = 1500)
}

#################### Application Public Subnets ####################

resource "google_compute_subnetwork" "application-public-subnet" {
  count         = length(var.app-public-subnet-cidrs)
  name          = "application-public-subnet-${count.index + 1}"
  ip_cidr_range = element(var.app-public-subnet-cidrs, count.index)
  region        = var.region
  network       = google_compute_network.custom-vpc-network.id
}

#################### Application Private Subnets ####################

resource "google_compute_subnetwork" "application-private-subnet" {
  count         = length(var.app-private-subnet-cidrs)
  name          = "application-private-subnet-${count.index + 1}"
  ip_cidr_range = element(var.app-private-subnet-cidrs, count.index)
  region        = var.region
  network       = google_compute_network.custom-vpc-network.id
}

#################### Database Private Subnets ####################

resource "google_compute_subnetwork" "database-private-subnet" {
  count         = length(var.db-private-subnet-cidrs)
  name          = "database-private-subnet-${count.index + 1}"
  ip_cidr_range = element(var.db-private-subnet-cidrs, count.index)
  region        = var.region
  network       = google_compute_network.custom-vpc-network.id
}

#################### Proxy Subnet For LB ####################

resource "google_compute_subnetwork" "proxy-subnetwork" {
  name          = "proxy-subnetwork"
  ip_cidr_range = var.proxy-subnet-cidr
  region        = var.region
  network       = google_compute_network.custom-vpc-network.id
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
}

#################### Firewall for Application Public Subnets ####################

resource "google_compute_firewall" "public-firewall" {
  name    = "public-firewall"
  network = google_compute_network.custom-vpc-network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = var.public-firewall-ports
  }

  source_ranges = ["0.0.0.0/0"]  ## This firewall has opened to internet. So, Make sure you are attaching this firewall only to those VMs which you want to be available to public internet
  target_tags   = ["web-public"] ## Remember to add this tag to VMs in Public Subnet
}

#################### Firewall for Application Private Subnets ####################

resource "google_compute_firewall" "private-firewall" {
  name    = "private-firewall"
  network = google_compute_network.custom-vpc-network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = var.private-firewall-ports
  }

  source_ranges = [var.app-public-subnet-cidrs[0], var.app-public-subnet-cidrs[1], var.app-private-subnet-cidrs[0], var.app-private-subnet-cidrs[1], var.db-private-subnet-cidrs[0], var.db-private-subnet-cidrs[1], var.proxy-subnet-cidr] ## Allowing traffic only from defined subnet cidrs
  target_tags   = ["web-private"]                                                                                                                                                                                                           ## Remember to add this tag to VMs in Private Subnet
}

#################### Firewall for Database Private Subnets ####################

resource "google_compute_firewall" "db-firewall" {
  name    = "db-firewall"
  network = google_compute_network.custom-vpc-network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = var.db-firewall-ports
  }

  source_ranges = [var.app-public-subnet-cidrs[0], var.app-public-subnet-cidrs[1], var.app-private-subnet-cidrs[0], var.app-private-subnet-cidrs[1], var.db-private-subnet-cidrs[0], var.db-private-subnet-cidrs[1], var.proxy-subnet-cidr] ## Allowing traffic only from defined subnet cidrs
  target_tags   = ["db-private"]                                                                                                                                                                                                            ## Remember to add this tag to DBs in Private Subnet
}