# Example: Complete Stack

A two-tier network (web + app) demonstrating all Phase 1 modules composed together:

- Resource group
- VNet with two subnets (web, app)
- NSG per subnet with tier-specific rules
- Route table on the app subnet forcing egress through a firewall appliance

```bash
terraform init
terraform plan
terraform apply
```
