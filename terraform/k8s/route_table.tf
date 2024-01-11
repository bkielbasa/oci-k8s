resource "oci_core_route_table" "route_table" {
  compartment_id = var.compartment_id 
  vcn_id         = oci_core_virtual_network.vcn.id

  display_name = "k8s-cluster"
  route_rules {
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
    destination       = "0.0.0.0/0"
  }
}