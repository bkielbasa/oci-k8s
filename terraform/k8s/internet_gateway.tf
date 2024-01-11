resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.compartment_id 
    vcn_id         = oci_core_virtual_network.vcn.id
    display_name   = "k8s-cluster"
}