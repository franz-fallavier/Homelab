resource "proxmox_vm_qemu" "gitlab-runner" {
  count       = 2
  name        = "gitlab-runner-${count.index + 1}"
  desc        = "Ubuntu Cloud Hosting GitLab-Runner"
  vmid        = "21${count.index + 1}"
  target_node = "zigris"
  agent       = 0
  clone       = "ubuntu-cloud-24.04-0020"
  cores       = 2
  sockets     = 1
  numa        = true
  vcpus       = 0
  cpu         = "host"
  memory      = 2048


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
          size    = 20
        }
      }
    }
  }
  boot         = "order=scsi0"
  os_type      = "cloud-init"
  searchdomain = "gitlab-runner-${count.index + 1}"
  nameserver   = "10.0.2.3"
  ipconfig0    = "ip=dhcp"
  ciuser       = var.proxmox_cloudinit_user
  sshkeys      = var.proxmox_cloudinit_public_key
}
