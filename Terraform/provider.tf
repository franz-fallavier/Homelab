terraform {
  required_version = ">= 1.9.8"
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

variable "proxmox_api_url" {
  type = string
}
variable "proxmox_api_token_id" {
  type      = string
  sensitive = true
}
variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}
variable "proxmox_cloudinit_user" {
  type = string
}
variable "proxmox_cloudinit_public_key" {
  type = string
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
}
