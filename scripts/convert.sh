#!/bin/bash
# Usage: ./convert.sh <vm-name> <vmdk-path>
VMNAME=$1
VMDK_PATH=$2
QCOW_PATH="vm-images/${VMNAME}.qcow2"

echo "Converting VMDK to QCOW2..."
qemu-img convert -f vmdk "$VMDK_PATH" -O qcow2 "$QCOW_PATH" || exit 1
echo "Conversion done: $QCOW_PATH"