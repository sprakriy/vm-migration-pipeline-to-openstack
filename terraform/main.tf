provider "openstack" {
  auth_url    = "http://127.0.0.1:5000/v3"
  region      = "RegionOne"
  user_name   = "admin"
  password    = "YOUR_MICROSTACK_PASSWORD"
  project_name = "admin"
  domain_name = "Default"
}

resource "openstack_compute_instance_v2" "migrated_vm" {
  name        = "migrated-vm"
  image_name  = "myvm"
  flavor_name = "m1.small"

  network {
    name = "private"
  }
}