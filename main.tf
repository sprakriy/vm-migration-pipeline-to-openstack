# This file calls your module and passes the variables from your CI/CD pipeline
module "openstack_vm" {
  source       = "./modules/openstack-vm"
  
  # Inputs from your GitHub Action - these will be populated
  # during the 'terraform apply' command
  vm_name      = var.vm_name
  vmdk_path    = var.vmdk_path
  qcow_path    = var.qcow_path
  flavor_name  = var.flavor_name
  network_name = var.network_name
}

# Define the variables here so the root module can accept them
# from the command line flags (e.g., -var="vm_name=...")
variable "vm_name" { type = string }
variable "vmdk_path" { type = string }
variable "qcow_path" { type = string }
variable "flavor_name" { type = string }
variable "network_name" { type = string }