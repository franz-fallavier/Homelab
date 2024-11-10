resource "proxmox_vm_qemu" "gitlab" {
  name        = "gitlab"
  desc        = "Ubuntu Cloud Hosting GitLab"
  vmid        = "201"
  target_node = "zigris"
  agent       = 0
  clone       = "cloudinit-ubuntu-24.04"
  cores       = 8
  sockets     = 1
  numa        = true
  vcpus       = 0
  cpu         = "host"
  memory      = 16384

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"
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
          size    = 160
        }
      }
    }
  }
  boot         = "order=scsi0"
  os_type      = "cloud-init"
  searchdomain = "gitlab"
  nameserver   = "10.0.2.3"
  ipconfig0    = "ip=dhcp"
  ciuser       = var.proxmox_cloudinit_user
  sshkeys      = var.proxmox_cloudinit_public_key
}
