terraform {
  required_providers {
      digitalocean = {
          source = "digitalocean/digitalocean"
          version = "~> 2.0"
      }
  }
}

variable "do_token" {}
variable "ssh_key_private" {}
variable "droplet_ssh_key_id" {}
variable "droplet_size" {}
variable "droplet_region" {}

provider "digitalocean" {
    token = "${var.do_token}"
}
#creacion VPC
resource "digitalocean_vpc" "vpct" {
    name = "vpct"
    region = "nyc1"
    ip_range = "192.168.1.0/24"
  
}

#server 1
resource "digitalocean_droplet" "wserver" {
    image  = "centos-7-x64"
    name   = "wserver-1"
    region = "${var.droplet_region}"
    size   = "${var.droplet_size}"
    vpc_uuid = digitalocean_vpc.vpct.id
    ssh_keys = ["${var.droplet_ssh_key_id}"]

    provisioner "remote-exec" {
        inline = [
          "yum install python -y",
        ]

         connection {
            host        = "${self.ipv4_address}"
            type        = "ssh"
            user        = "root"
            private_key = "${file("${var.ssh_key_private}")}"
        }
    }

    provisioner "local-exec" {
        environment = {
            PUBLIC_IP                 = "${self.ipv4_address}"
            PRIVATE_IP                = "${self.ipv4_address_private}"
            ANSIBLE_HOST_KEY_CHECKING = "False" 
        }

        working_dir = "playbooks/"
        command     = "ansible-playbook -u root --private-key ${var.ssh_key_private} -i ${self.ipv4_address}, wordpress_playbook.yml"
    }
}

# Server 2 
resource "digitalocean_droplet" "ej" {
    image  = "ubuntu-18-04-x64"
    name   = "ej-1"
    region = "${var.droplet_region}"
    size   = "${var.droplet_size}"
    vpc_uuid = digitalocean_vpc.vpct.id
    ssh_keys = ["${var.droplet_ssh_key_id}"]
}