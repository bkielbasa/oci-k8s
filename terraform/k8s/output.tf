output "control_plane_ip" {
  value = oci_core_instance.control-plane.public_ip
}

output "workers_ip" {
  value = join(", ", oci_core_instance.worker.*.public_ip)
}

output "workers_ocid" {
  value = join(", ", oci_core_instance.worker.*.id)
}
