#!/bin/bash
# Usage: ./upload.sh <vm-name> <qcow-path>

VMNAME=$1
QCOW_PATH=$2

# Load MicroStack/OpenStack credentials
source /var/snap/microstack/common/etc/microstack.rc

echo "Uploading $QCOW_PATH to OpenStack..."
openstack image create "$VMNAME" \
  --file "$QCOW_PATH" \
  --disk-format qcow2 \
  --container-format bare \
  --public || exit 1

echo "Upload complete!"