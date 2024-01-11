data "oci_core_images" "base-image" {
    compartment_id = var.compartment_id

  operating_system = "Canonical Ubuntu"

  filter {
    name   = "operating_system_version"
    values = ["22.04"]
  }
}
