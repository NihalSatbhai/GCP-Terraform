#################### Retrieving data of google compute image ####################
data "google_compute_image" "debian" {
  family  = var.family
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


#################### Creating Private Instance Template ####################
resource "google_compute_instance_template" "private-instance-template" {
  name         = "private-instance"
  machine_type = var.machine-type
  tags         = ["web-public"] ## Making sure that this tag should be added as this is the same tag which we used while creating public firewall
  disk {
    source_image = data.google_compute_image.debian.self_link
    auto_delete  = true
    boot         = true
  }
  network_interface {
    subnetwork = var.private-subnetwork
    access_config {
      // Ephemeral public IP  ## Random External IP will be Assigned
    }
  }
  metadata = {
    ssh-keys = "${var.ssh-user}:${tls_private_key.web-key.public_key_openssh}"
  }

  metadata_startup_script = var.metadata-script
}


#################### Creating HTTP Health Check ####################
resource "google_compute_region_health_check" "http-health-check" {
  name = "http-health-check"

  check_interval_sec  = 5 # How often (in seconds) to send a health check
  healthy_threshold   = 2 # A so-far unhealthy instance will be marked healthy after this many consecutive successes
  timeout_sec         = 5 # How long (in seconds) to wait before claiming failure
  unhealthy_threshold = 2 # A so-far healthy instance will be marked unhealthy after this many consecutive failures

  http_health_check {
    port         = 80
    request_path = "/"
  }
}


#################### Creating Private Instance Group Manager ####################
resource "google_compute_instance_group_manager" "private-igm" {
  name = "private-igm"

  base_instance_name = "application-private-vm"
  zone               = var.zone

  version {
    instance_template = google_compute_instance_template.private-instance-template.id
  }

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_region_health_check.http-health-check.id
    initial_delay_sec = 300
  }
}


#################### Creating Autoscaler ####################
resource "google_compute_autoscaler" "private-autoscaler" {
  name   = "private-autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.private-igm.id

  autoscaling_policy {
    max_replicas    = 2
    min_replicas    = 1
    cooldown_period = 120 # The number of seconds that the autoscaler should wait before it starts collecting information from a new instance

    load_balancing_utilization {
      target = 0.8
    }
  }
}