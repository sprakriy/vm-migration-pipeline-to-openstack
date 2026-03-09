resource "null_resource" "image_lifecycle" {
  triggers = {
    vm_name   = var.vm_name
    qcow_path = var.qcow_path
  }

  provisioner "local-exec" {
    command = <<EOT
      # 1. Convert VMDK to QCOW2
      qemu-img convert -f vmdk ${var.vmdk_path} -O qcow2 ${var.qcow_path}

      # 2. Inject Drivers and Cloud-Init
      # This ensures the VM can boot on KVM and accept SSH keys
      virt-customize -a ${var.qcow_path} \
        --install cloud-init,qemu-guest-agent \
        --run-command "systemctl enable cloud-init" \
        --selinux-relabel
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -f ${self.triggers.qcow_path}"
  }
}

resource "openstack_images_image_v2" "vm_image" {
  depends_on       = [null_resource.image_lifecycle]
  name             = "${var.vm_name}-image"
  image_source_url = "file://${var.qcow_path}"
  container_format = "bare"
  disk_format      = "qcow2"
  
  # Added metadata properties for OpenStack to recognize the drivers
  properties = {
    hw_disk_bus         = "virtio"
    hw_vif_model        = "virtio"
    hw_qemu_guest_agent = "yes"
  }
}

# 3. Manage the Compute Instance
resource "openstack_compute_instance_v2" "vm_instance" {
  name        = var.vm_name
  image_id    = openstack_images_image_v2.vm_image.id
  flavor_name = var.flavor_name

  network {
    name = var.network_name
  }
}