output "control_plane_ip" {
  value = module.k8s.control_plane_ip
}

output "workers_ip" {
  value = module.k8s.workers_ip
}

output "workers_ocid" {
  value = module.k8s.workers_ocid
}
