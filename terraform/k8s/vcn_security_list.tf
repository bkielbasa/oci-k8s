# allow communication between nodes directly using private IPs
resource "oci_core_security_list" "intra" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "intra-vcn"

  ingress_security_rules {
    stateless   = true
    protocol    = "all"
    source      = "10.240.0.0/24"
    source_type = "CIDR_BLOCK"
  }
}

# allow to connect to all nodes using SSH from any IP
resource "oci_core_security_list" "ssh" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "ssh"

  ingress_security_rules {
    stateless   = false
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"

    tcp_options {
      min = 22
      max = 22
    }
  }
}

resource "oci_core_security_list" "ingress-access" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "worker"

  ingress_security_rules {
    stateless   = false
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"

    # NodePort Services
    tcp_options {
      min = 30000
      max = 32767
    }
  }
}

# allow all nodes to communicate with Internet
resource "oci_core_security_list" "egress-access" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vcn.id
  display_name   = "egress access"

  egress_security_rules {
    stateless   = false
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}
