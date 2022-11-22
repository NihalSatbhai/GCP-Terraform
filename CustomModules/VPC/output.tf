## Define each output whose value you want to use in other modules or in root module (Based on your requirements)

output "vpc-id" {
  value = google_compute_network.custom-vpc-network.id
}

output "public-subnet-name" {
  value = google_compute_subnetwork.application-public-subnet[0].name
}

output "private-subnet-name" {
  value = google_compute_subnetwork.application-private-subnet[0].name
}

output "proxy-subnet-name" {
  value = google_compute_subnetwork.proxy-subnetwork.name
}