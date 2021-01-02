provider "google" {
    project = "axial-history-294603"
    region  = "us-central1"
}

# resource "google_compute_address" "vm_static_ip" {
#   name = "terraform-static-ip"
# }

# resource "google_compute_firewall" "firewall" {
#   name    = "firewall"
#   network = google_compute_network.vpc_network.name
#   allow {
#     protocol = "tcp"
#     ports    = ["80", "22"]
#   }
# }

# resource "google_compute_network" "vpc_network" {
#   name = "terraform-network"
# }

# resource "google_compute_instance" "ubu1" {
#     name         = "ubu1"
#     machine_type = "f1-micro"
#     zone         = "us-central1-a"
#     boot_disk {
#         initialize_params {
#             image = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"
#             size  = 10
#         }
#     }
#     network_interface { 
#         network = google_compute_network.vpc_network.name
#         # access_config {
#         #     nat_ip = google_compute_address.vm_static_ip.address
#         # }
#     }
#     tags = [ "ubu1", "allow-lb-service" ]
#     metadata_startup_script = file("ubu1nginx.bash")

#     # provisioner "local-exec" {
#     #     command = "echo ${google_compute_instance.ubu1.name}:  ${google_compute_instance.ubu1.network_interface[0].access_config[0].nat_ip} >> ip_address.txt"
#     # }
# }
# -------------------------------------------------

data "template_file" "instance_startup_script" {
  template = file("ubu1nginx.bash")
#   vars = {
#     PROXY_PATH = ""
#   }
}

resource "google_service_account" "instance-group" {
  account_id = "instance-group"
}

module "instance_template" {
  source               = "terraform-google-modules/vm/google//modules/instance_template"
  version              = "~> 1.0.0"
  subnetwork           = google_compute_subnetwork.subnetwork.self_link
  source_image_family  = var.image_family
  source_image_project = var.image_project
  startup_script       = data.template_file.instance_startup_script.rendered

  service_account = {
    email  = google_service_account.instance-group.email
    scopes = ["cloud-platform"]
  }
}

module "managed_instance_group" {
  source            = "terraform-google-modules/vm/google//modules/mig"
  version           = "~> 1.0.0"
  region            = var.region
  target_size       = 2
  hostname          = "mig-simple"
  instance_template = module.instance_template.self_link

  target_pools = [
    module.load_balancer_default.target_pool,
    module.load_balancer_no_hc.target_pool,
    module.load_balancer_custom_hc.target_pool
  ]

  named_ports = [{
    name = "http"
    port = 80
  }]
}

module "load_balancer_default" {
  name         = "basic-load-balancer-default"
  source       = "../../"
  region       = var.region
  service_port = 80
  network      = google_compute_network.network.name

  target_service_accounts = [google_service_account.instance-group.email]
}

module "load_balancer_no_hc" {
  name                 = "basic-load-balancer-no-hc"
  source               = "../../"
  region               = var.region
  service_port         = 80
  network              = google_compute_network.network.name
  disable_health_check = true

#   target_service_accounts = [google_service_account.instance-group.email]
}

module "load_balancer_custom_hc" {
  name         = "basic-load-balancer-custom-hc"
  source       = "../../"
  region       = var.region
  service_port = 8080
  network      = google_compute_network.network.name
  health_check = local.health_check

#   target_service_accounts = [google_service_account.instance-group.email]
}
# ----------------------------------------------------------------------
# OUTPUT  
# output "google_compute_address_vm_static_ip" {
#   value = google_compute_address.vm_static_ip.address
# }


# output "ubu2_public_ip" {
#   value = aws_instance.ubu2.public_ip
# }

# output "ubu1_availability_zone" {
#   value = google_compute_instance.ubu1.availability_zone
# }

# output "ubu2_availability_zone" {
#   value = aws_instance.ubu2.availability_zone
# }

# output "aws_elb_dns_name" {
#   value = aws_elb.loadbalancer.dns_name
# }