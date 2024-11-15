resource "proxmox_vm_qemu" "k3s-cluster" {
  count       = 3
  name        = "k3s-node-${count.index + 1}"
  desc        = "Ubuntu Cloud Hosting k3s"
  vmid        = "33${count.index + 1}"
  target_node = "zigris"
  agent       = 1
  clone       = "ubuntu-cloud-24.04-0080"
  cores       = 4
  sockets     = 1
  numa        = true
  vcpus       = 0
  cpu         = "host"
  memory      = 4096


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
          size    = 80
        }
      }
    }
  }
  boot         = "order=scsi0"
  os_type      = "cloud-init"
  searchdomain = "k3s-node-${count.index + 1}"
  nameserver   = "10.0.2.3"
  ipconfig0    = "ip=dhcp"
  ciuser       = var.proxmox_cloudinit_user
  sshkeys      = var.proxmox_cloudinit_public_key
}
