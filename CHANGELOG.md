# Changelog

All notable changes to this project will be documented in this file. 

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.0] (Unreleased)

### Changed

- Updated proxy configuration so that we use the term `portal` instead of `ui`. [#56](https://github.com/unity-sds/unity-portal/issues/56)

## [0.2.0] 2025-01-14

### Added 

- Added tags specification for resources managed by terraform configuration [#4](https://github.com/unity-sds/unity-ui-infra/issues/4)
- Fixed how tags are specified to resolve issue when Terraform code is executed [#9](https://github.com/unity-sds/unity-ui-infra/issues/9)
- Updated proxy configuration. Our application is now accessible using the term `ui` instead of `dashboard` [#15](https://github.com/unity-sds/unity-ui-infra/issues/15)
- Updated terraform configurations so they use the term `ui` instead of `dashboard` [#15](https://github.com/unity-sds/unity-ui-infra/issues/15)

## [0.1.0] 2024-04-15

### Added 

- Added initial (non-working) terraform configuration in support of deploying Unity UI to Unity Marketplace [#9](https://github.com/unity-sds/unity-sds-portal/issues/9)