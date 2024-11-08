# Homelab
This repository is a ledger for my Homelab Journey

## Goals

### Software

#### General Home Purpose
Homepage
Pi-Hole
Home Assitant
TrueNas Scale
NextCloud
Ceph

#### General Work Purpose
Proxmox
Code Server
Docker
Docker Hub
Portainer
Docker Swarm
Kubernetes
Rancher

#### Project Management
Taiga
Penpot

#### Monitoring
Prometheus
Uptime-Kuma
Grafana

#### CI/CD
Gitlab
Gitlab Runner

#### IaC
Terraform
Ansible

#### Games
Factorio server
Minecraft server
Vanilla Wow VMangos


### Hardware

1 Server hosting TrueNas Scale
3 Servers for Proxmox HA
1 Cluster of Raspberry Pi 5 (3) for static services (like Homepage)
1 Cluster of old Raspberry Pi(7) for fun
1 VM for Code Server
1 VM for Gitlab
1 UPS for servers
1 UPS for network devices
1 K8s Cluster (3 Nodes) as Staging Env before production
1 Docker swarm ( 3 Nodes) as Staging Env before production
1 VM for Game Servers


### Network

WAN Optical Fiber (8Gb down ,1 Gb up) or Starlink (300Mb down, 30Mb up)
10Gb Home Network
Router -> UDM Pro 
Switches -> Better ones for PoE++ 
Access Point -> U7 Pro

#### Configuration
4 Vlans
10.0.1.1 -> Default
10.0.2.1 -> Server
10.0.3.1 -> VPN
10.0.4.1 -> Clients
10.0.1O.1 -> Homelab ?
10.0.20.1 -> IoT




