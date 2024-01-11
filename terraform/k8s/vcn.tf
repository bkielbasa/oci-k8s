resource "oci_core_virtual_network" "vcn" {
  cidr_block     = "10.240.0.0/24"
  dns_label      = "vcn"
  compartment_id = var.compartment_id
  display_name   = "k8s-cluster"
}

resource "oci_core_subnet" "subnet" {
  cidr_block     = "10.240.0.0/24"
  compartment_id = var.compartment_id 
  vcn_id         = oci_core_virtual_network.vcn.id

  display_name      = "kubernetes"
  dns_label         = "subnet"
  route_table_id    = oci_core_route_table.route_table.id
  security_list_ids = [oci_core_security_list.intra.id, oci_core_security_list.ingress-access.id, oci_core_security_list.egress-access.id, oci_core_security_list.ssh.id]
}
