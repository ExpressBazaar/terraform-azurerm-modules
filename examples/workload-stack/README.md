# Example: Workload Stack (Phase 1 + 2 + 3)

A full application platform composing every phase, demonstrating cross-phase wiring:

- Network with AKS and app subnets — the app subnet is delegated to `Microsoft.Web/serverFarms` (Phase 1)
- Log Analytics with ContainerInsights (Phase 2)
- Container Registry (Phase 3)
- AKS cluster wired to Log Analytics for monitoring and granted `AcrPull` on the registry (Phase 3)
- Linux Web App with VNet integration (Phase 3)
- SQL server + database with Azure AD admin (Phase 3)

## Usage

```bash
terraform init
terraform plan -var="sql_admin_group_object_id=<your-aad-group-object-id>"
terraform apply -var="sql_admin_group_object_id=<your-aad-group-object-id>"
```
