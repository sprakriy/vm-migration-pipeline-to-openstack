# 1. Manage the lifecycle of the local QCOW2 file
resource "null_resource" "image_lifecycle" {
  triggers = {
    qcow_path = var.qcow_path
  }

  # Convert before creation
  provisioner "local-exec" {
    command = "qemu-img convert -f vmdk ${var.vmdk_path} -O qcow2 ${var.qcow_path}"
  }

  # Clean up local file after destruction
  provisioner "local-exec" {
    when    = destroy
    command = "rm -f ${self.triggers.qcow_path}"
  }
}

# 2. Manage the Glance Image in OpenStack
resource "openstack_images_image_v2" "vm_image" {
  depends_on       = [null_resource.image_lifecycle]
  name             = "${var.vm_name}-image"
  image_source_url = "file://${var.qcow_path}"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "private"
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