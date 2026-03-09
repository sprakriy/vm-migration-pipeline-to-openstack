# vm-migration-pipeline-to-openstack
This project covers the VM migration pipeline to Open Stack
vm-migration-pipeline/
├─ scripts/
│   ├─ convert.sh
│   ├─ upload.sh
├─ terraform/
│   └─ main.tf
├─ .github/workflows/
│   └─ migrate.yml  # GitHub Actions pipeline
└─ vm-images/
    └─ myvm.vmdk

Changed flow to have everything under terraform control.

├── bootstrap/
│   └── backend.tf            # Remote state + Locking
├── modules/
│   └── openstack-vm/
│       ├── main.tf           # Conversion, Upload, Instance logic
│       └── variables.tf      # Inputs for VM and paths
├── .github/
│   └── workflows/
│       └── migrate.yaml      # Pipeline (S3 download -> Terraform Apply)
└── main.tf                   # Root module caller