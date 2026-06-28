# terraform-azurerm-modules

A versioned library of reusable, composable Terraform modules for Microsoft Azure.

## Design Principles

- **No provider blocks inside modules** — only `required_providers`. Consumers configure the provider.
- **Composable** — modules expose IDs/names as outputs so they chain together across phases.
- **Single responsibility** — each module owns one logical resource and its tightly-coupled associations.
- **Input validation** — fail fast on bad CIDRs, names, SKUs, etc.
- **Versioned via Git tags** — consumers pin with `?ref=v1.2.0`.

## Available Modules

### Phase 1 — Network foundation

| Module                              | Purpose                                          |
|-------------------------------------|--------------------------------------------------|
| [resource-group](./modules/resource-group) | Azure Resource Group                     |
| [vnet](./modules/vnet)              | Virtual Network                                  |
| [subnet](./modules/subnet)          | Subnet with service endpoints & delegations      |
| [nsg](./modules/nsg)                | Network Security Group + optional association    |
| [route-table](./modules/route-table)| Route Table + optional association               |

### Phase 2 — Platform services

| Module                                    | Purpose                                    |
|-------------------------------------------|--------------------------------------------|
| [key-vault](./modules/key-vault)          | Key Vault with RBAC + network firewall     |
| [storage-account](./modules/storage-account) | Storage Account with secure defaults    |
| [log-analytics](./modules/log-analytics)  | Log Analytics workspace + solutions        |
| [private-dns-zone](./modules/private-dns-zone) | Private DNS zone + VNet links         |

### Phase 3 — Workload services

| Module                                          | Purpose                              |
|-------------------------------------------------|--------------------------------------|
| [aks](./modules/aks)                            | AKS cluster (CNI, autoscale, OMS)    |
| [app-service](./modules/app-service)            | Linux Web App + plan + VNet integ.   |
| [linux-vm](./modules/linux-vm)                  | Linux VM with NIC, optional public IP, and SSH auth |
| [sql](./modules/sql)                            | SQL server + databases (AAD admin)   |
| [container-registry](./modules/container-registry) | Azure Container Registry          |

## Consuming a Module

```hcl
module "rg" {
  source   = "git::https://github.com/yourorg/terraform-azurerm-modules.git//modules/resource-group?ref=v1.2.0"
  name     = "rg-app-dev"
  location = "uksouth"
}
```

The `//modules/<name>?ref=<tag>` syntax pins a specific module version from this monorepo. You can pin different modules to different tags, though most teams bump everything to the latest tag together.

## Examples

- [simple-network](./examples/simple-network) — RG + VNet + subnet + NSG (Phase 1)
- [complete-stack](./examples/complete-stack) — two-tier web/app network with routing (Phase 1)
- [platform-stack](./examples/platform-stack) — network + Key Vault, Storage, Log Analytics, Private DNS (Phase 1 + 2)
- [workload-stack](./examples/workload-stack) — full app platform: AKS, ACR, App Service, SQL (Phase 1 + 2 + 3)

## CI

`validate.yml` auto-discovers every directory containing `.tf` files, so new modules are validated without editing the workflow. It runs: fmt check, per-directory init/validate matrix, TFLint, and a Trivy IaC security scan. `release.yml` cuts a GitHub release with generated notes on `v*.*.*` tags.

## Releasing

```bash
git tag v1.2.0
git push origin v1.2.0
```

Bump versions per [SemVer](https://semver.org/): MAJOR for breaking input/output changes, MINOR for new modules or features, PATCH for fixes. Adding a whole phase of new modules is a MINOR bump.

## Version history

| Tag    | Contents                                          |
|--------|---------------------------------------------------|
| v1.0.0 | Phase 1 network modules                           |
| v1.1.0 | Phase 2 platform modules                          |
| v1.2.0 | Phase 3 workload modules                          |
