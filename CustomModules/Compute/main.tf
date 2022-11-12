#################### Retrieving data of google compute image ####################
data "google_compute_image" "debian" {
    family = var.family
    project = var.family-project
}


#################### Creating SSH Key ####################
resource "tls_private_key" "web-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


#################### Storing Private SSH Key Locally ####################
resource "local_file" "web-key" {
  content         = tls_private_key.web-key.private_key_pem
  filename        = "web-key.pem"
  file_permission = "0400"
}


#################### Creating VM with External IP in Public Subnet #################### (This will also act as jump host to conect to private VMs)
resource "google_compute_instance" "application-public-instance" {
  name         = "application-public-instance"
  machine_type = var.machine-type
  zone         = var.zone
  tags = [ "web-public" ] ## Making sure that this tag should be added as this is the same tag which we used while creating public firewall
  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian.self_link ## Using latest image which we retrieved from data
      ## Use below block if you want to add labels
      labels = {
        name = "application-public-instance"
      }
    }
  }
  network_interface {
    subnetwork = var.subnetwork
    access_config {
      // Ephemeral public IP  ## Random External IP will be Assigned
    }
  }
  metadata = {
      ssh-keys = "${var.ssh-user}:${tls_private_key.web-key.public_key_openssh}"
  }

  metadata_startup_script = var.metadata-script

  provisioner "file" {
    source = "web-key.pem"
    destination = "/home/${var.ssh-user}/web-key.pem"
    connection {
      type = "ssh"
      user = var.ssh-user
      host = self.network_interface[0].access_config[0].nat_ip
      agent = false
      private_key = file(local_file.web-key.filename)
    }
  }
}


#################### Creating VM in Private Subnet ####################
resource "google_compute_instance" "application-private-instance" {
  name         = "application-private-instance"
  machine_type = var.machine-type
  zone         = var.zone
  tags = [ "web-private" ] ## Making sure that this tag should be added as this is the same tag which we used while creating public firewall
  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian.self_link ## Using latest image which we retrieved from data
      ## Use below block if you want to add labels
      labels = {
        name = "application-private-instance"
      }
    }
  }
  network_interface {
    subnetwork = var.subnetwork
    ## Remeber How we are not using access_config block here (This will not assign any external IP to VM)
    # access_config {
    #   // Ephemeral public IP  ## Random External IP will be Assigned
    # }
  }
  metadata = {
      ssh-keys = "${var.ssh-user}:${tls_private_key.web-key.public_key_openssh}"
  }
}