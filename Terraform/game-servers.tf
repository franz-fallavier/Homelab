resource "proxmox_vm_qemu" "minecraft-server" {
  name        = "minecraft-server"
  desc        = "Ubuntu Cloud Hosting Minecraft Servers"
  vmid        = "410"
  target_node = "zigris"
  agent       = 1
  clone       = "ubuntu-cloud-24.04-0040"
  cores       = 4
  sockets     = 1
  numa        = true
  vcpus       = 0
  cpu         = "host"
  memory      = 4096
  onboot      = true
  startup     = "order=1"

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  scsihw = "virtio-scsi-pci"
  serial {
    id   = 0
    type = "socket"

  }
  vga {
    type   = "std"
    memory = 4
  }

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local-nvme"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage = "local-nvme"
          size    = 40
        }
      }
    }
  }
  boot         = "order=scsi0"
  os_type      = "cloud-init"
  searchdomain = "minecraft-server"
  nameserver   = "10.0.2.3"
  ipconfig0    = "ip=dhcp"
  ciuser       = var.proxmox_cloudinit_user
  sshkeys      = var.proxmox_cloudinit_public_key
}

resource "proxmox_vm_qemu" "factorio-server" {
  name        = "factorio-server"
  desc        = "Ubuntu Cloud Hosting Factorio Servers"
  vmid        = "420"
  target_node = "zigris"
  agent       = 1
  clone       = "ubuntu-cloud-24.04-0040"
  cores       = 4
  sockets     = 1
  numa        = true
  vcpus       = 0
  cpu         = "host"
  memory      = 4096
  onboot      = true
  startup     = "order=1"

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  scsihw = "virtio-scsi-pci"
  serial {
    id   = 0
    type = "socket"

  }
  vga {
    type   = "std"
    memory = 4
  }

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local-nvme"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          storage = "local-nvme"
          size    = 40
        }
      }
    }
  }
  boot         = "order=scsi0"
  os_type      = "cloud-init"
  searchdomain = "factorio-server"
  nameserver   = "10.0.2.3"
  ipconfig0    = "ip=dhcp"
  ciuser       = var.proxmox_cloudinit_user
  sshkeys      = var.proxmox_cloudinit_public_key
}
