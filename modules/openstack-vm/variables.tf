variable "vm_name" {
  description = "The unique name for your VM instance"
  type        = string
}

variable "vmdk_path" {
  description = "Path to the source VMDK file on the runner"
  type        = string
}

variable "qcow_path" {
  description = "Path where the converted QCOW2 file will be stored"
  type        = string
}

variable "flavor_name" {
  description = "OpenStack flavor (e.g., m1.small, m1.medium)"
  type        = string
  default     = "m1.small"
}

variable "network_name" {
  description = "The private network name in OpenStack"
  type        = string
  default     = "private"
}