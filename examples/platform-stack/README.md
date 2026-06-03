# Example: Platform Stack (Phase 1 + Phase 2)

Network foundation plus shared platform services, showing Phase 2 modules consuming Phase 1 outputs:

- Resource group + VNet + private-endpoints subnet (Phase 1)
- Log Analytics workspace (Phase 2)
- Key Vault locked to the subnet (Phase 2)
- Storage account locked to the subnet (Phase 2)
- Private DNS zone linked to the VNet (Phase 2)

```bash
terraform init
terraform plan
terraform apply
```
