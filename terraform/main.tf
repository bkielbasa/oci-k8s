terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 4.84.0"
    }
  }
}

provider "oci" {
  tenancy_ocid         = var.tenancy_ocid
  user_ocid            = var.user_ocid
  fingerprint          = var.key_fingerprint
  private_key_path     = "/Users/bklimcza/Projects/ecommerce-infra/terraform/key.pem"
  private_key_password = var.private_key_password
  region               = var.region
}

module "k8s" {
  source         = "./k8s"
  compartment_id = var.tenancy_ocid
  ssh_public_key = tls_private_key.ssh.public_key_openssh
  ssh_private_key = tls_private_key.ssh.private_key_openssh
}
