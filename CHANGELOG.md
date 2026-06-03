# Changelog

All notable changes to this module library are documented here.
This project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [1.2.0] - 2026-06-03
### Added
- Phase 3 workload modules:
  - `aks` — AKS cluster with Azure CNI, autoscaling node pool, OMS agent, optional AcrPull role
  - `app-service` — Linux App Service Plan + Web App with VNet integration
  - `sql` — Azure SQL server + databases with Azure AD administrator support
  - `container-registry` — Azure Container Registry with geo-replication
- `workload-stack` example composing Phases 1, 2, and 3
- CI validate workflow now auto-discovers Terraform directories (no manual matrix edits)

## [1.1.0] - 2026-06-03
### Added
- Phase 2 platform modules:
  - `key-vault` — RBAC authorization, purge protection, network firewall
  - `storage-account` — secure defaults, containers, network rules
  - `log-analytics` — workspace with retention, quota, solutions
  - `private-dns-zone` — zone with VNet links and A records
- `platform-stack` example composing Phases 1 and 2

## [1.0.0] - 2026-06-03
### Added
- Phase 1 network modules: `resource-group`, `vnet`, `subnet`, `nsg`, `route-table`
- `simple-network` and `complete-stack` examples
- CI: fmt, validate, tflint, Trivy security scan
- CI: tag-triggered release with auto-generated notes
