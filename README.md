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