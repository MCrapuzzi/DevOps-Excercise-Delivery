# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "proxmox" {
  pm_api_url              = var.pm_api_url
  pm_api_token_id         = var.pm_user
  pm_api_token_secret     = var.pm_password
  pm_tls_insecure         = true
}

resource "proxmox_vm_qemu" "vm" {
  count       = 3
  name        = "vm-${count.index}"
  target_node = var.target_node

  clone = var.template_name

  memory = 2048

  cpu {
    cores = 2
  }

  disk {
    size    = "20G"
    type    = "disk"
    storage = "local-lvm"
    slot    = "scsi0"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
    id     = 0
  }

  os_type = "cloud-init"

  ipconfig0 = "ip=dhcp"


}