resource "oci_core_instance" "control-plane" {
  compartment_id      = var.compartment_id
  shape               = "VM.Standard.A1.Flex"
  availability_domain = lookup(data.oci_identity_availability_domains.availability_domains.availability_domains[1], "name")
  display_name        = "control-plane"
  
  source_details {
    source_id   = data.oci_core_images.base-image.images[0].id
    source_type = "image"
  }

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.subnet.id
  }

  shape_config {
    memory_in_gbs = 6
    ocpus = 1
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.public_ip
    private_key = var.ssh_private_key
  }

  provisioner "remote-exec" {
    inline = [
      "sudo ufw allow from 10.240.0.0/24;sudo iptables -A INPUT -i ens3 -s 10.240.0.0/24 -j ACCEPT;sudo iptables -F;sudo iptables --flush;sudo iptables -tnat --flush",
    ]
  }

  metadata = {
    "ssh_authorized_keys" = var.ssh_public_key
  }
}
