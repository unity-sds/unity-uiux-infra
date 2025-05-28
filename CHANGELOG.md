# Changelog

All notable changes to this project will be documented in this file. 

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.4.0] (Unreleased)

### Added

- Integrated new security group for ALB so that it's ingress rule can be linked to the project's venue httpd proxy so that the proxy is the only service that can access it. [#22](https://github.com/unity-sds/unity-uiux-infra/issues/22)

### Changed

- Updated proxy configuration so that we use the term `portal` instead of `ui`. [#56](https://github.com/unity-sds/unity-portal/issues/56)
- Changed folder name from `terraform-unity-ui` to `terraform-unity-portal` [#18](https://github.com/unity-sds/unity-uiux-infra/issues/18)
- Updated CapVersion tag so that it matches the version of the Portal Container being deployed. This is managed manually.

## [0.3.0] 2025-04-23

### Changed

- Updated proxy configuration so that we use the term `portal` instead of `ui`. [#56](https://github.com/unity-sds/unity-portal/issues/56)
- Changed folder name from `terraform-unity-ui` to `terraform-unity-portal` [#18](https://github.com/unity-sds/unity-uiux-infra/issues/18)
- Updated CapVersion tag so that it matches the version of the Portal Container being deployed. This is managed manually.

### Fixed

- Portal container, was referencing `unity-ui` repo instead of `unity-portal` [#20](https://github.com/unity-sds/unity-uiux-infra/issues/20)

## [0.2.0] 2025-01-14

### Added 

- Added tags specification for resources managed by terraform configuration [#4](https://github.com/unity-sds/unity-ui-infra/issues/4)
- Fixed how tags are specified to resolve issue when Terraform code is executed [#9](https://github.com/unity-sds/unity-ui-infra/issues/9)
- Updated proxy configuration. Our application is now accessible using the term `ui` instead of `dashboard` [#15](https://github.com/unity-sds/unity-ui-infra/issues/15)
- Updated terraform configurations so they use the term `ui` instead of `dashboard` [#15](https://github.com/unity-sds/unity-ui-infra/issues/15)

## [0.1.0] 2024-04-15

### Added 

- Added initial (non-working) terraform configuration in support of deploying Unity UI to Unity Marketplace [#9](https://github.com/unity-sds/unity-sds-portal/issues/9)
