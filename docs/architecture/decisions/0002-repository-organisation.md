# 2. Repository Organisation

Date: 2024-09-13

## Status

Accepted

## Context

The repository could be better organised to see and understand the organisation of the resources and services that are being managed, in particular regional resources, account resources and global resources.

## Decision

- move modules that create regional resources into modules/region/modules
- move modules that create account/global or multi-region resources into modules/global/modules
- or refactor modules that create multi-region resources so that they are aware of being primary or secondary and create the right resources

I believe this will reduce the effort required in future to deploy the account standard in all regions we use (eu-west-1, eu-west-2 and us-east-1) and/or have active (eu-central-1 for example)

The outline for the repository should aim to be as follows.

```shell
.
├── docs
│   ├── architecture
|   |   └── decisions
|   |      └── 0001-record-architecture-decisions.md
|   |      └── 0002-repository-organisation.md
├── examples
│   ├── development_account
│   ├── full_example
│   └── production_account
├── modules
│   ├── account
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tf
│   │   └── variables.tf
│   ├── region
│   |   ├──modules
│   |   |   └── config
│   │   |   |   ├── main.tf
│   │   |   |   ├── outputs.tf
│   │   |   |   ├── terraform.tf
│   │   |   |   └── variables.tf
│   |   |   └── github_oidc_provider
│   │   |   |   ├── main.tf
│   │   |   |   ├── outputs.tf
│   │   |   |   ├── terraform.tf
│   │   |   |   └── variables.tf
│   |   |   └── s3_access_logging
│   │   |       ├── main.tf
│   │   |       ├── outputs.tf
│   │   |       ├── terraform.tf
│   │   |       └── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tf
│   │   └── variables.tf
│   ├── global
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tf
│   │   └── variables.tf
├── README.md
├── account.tf
├── data_sources.tf
├── regions.tf
├── global.tf
├── variables.tf
└── versions.tf
```

## Consequences

The folder structure will not be flat (seeing all the services and resource the module sets up at once), but will better represent where resources are created (region, account, global) and how they are created (modules). This will make it easier to understand the repository and the resources it manages.
