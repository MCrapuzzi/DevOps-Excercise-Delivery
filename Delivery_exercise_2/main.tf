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
  clone       = var.template_name


  agent = 1
  os_type = "cloud-init"
  memory = 1024

  # VM specifications
  cpu {
    type = "host"
    cores = 1
    sockets = 1
  }

  # Disk configuration
  disk {
    slot = "scsi0"
    type = "disk"
    storage = "local-lvm"
    size = "32G"
    cache = "writeback"
    replicate = true
  }

  disk {
    slot = "ide2"
    type = "cloudinit"
    storage = "local-lvm"
  }

  # Network configuration
  network {
    model = "virtio"
    bridge = "vmbr0"
    id = 0
  }

  # Cloud-init configuration
  ipconfig0 = "ip=dhcp"

  # Serial interface
  serial {
    id = 0
    type = "socket"
  }

  # Cloud-init user configuration
  ciuser = var.pm_ci_user
  cipassword = var.pm_ci_password


  # Boot order
  boot = "order=scsi0"

  scsihw = "virtio-scsi-pci"
}