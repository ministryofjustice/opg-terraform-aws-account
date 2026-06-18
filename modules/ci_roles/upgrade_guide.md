
# CI Role Boundary Migration Guide

This document outlines the recommended stages for migrating CI roles to use permissions boundaries safely and incrementally.

---

## Overview

The goal of this process is to introduce CI roles with permissions boundaries while maintaining existing functionality, and then progressively transition to the new model without disrupting services.

---

## Stage 1: Introduce Boundaried CI Roles

Create the new CI roles with boundaries enabled, while keeping the existing (non-boundaried) roles in all accounts.

Add the following configuration:

```hcl
ci_custom_policy_json = data.aws_iam_policy_document.deny_data_read.json
ci_boundaried_enabled = true
ci_boundary           = local.service_boundary
```

Define your `service_boundary` to include all required AWS services used by the account:

```hcl
service_boundary = [
  "dynamodb:*",
  "logs:*",
  "iam:*",
  "ec2:*",
  ...
]
```

Ensure this list includes all permissions required by your workloads.

---

## Stage 2: Apply Non-CI Boundary to Service Roles

Add a permissions boundary to all non-CI IAM roles in your service repository.

Example:

```hcl
resource "aws_iam_role" "example" {
  assume_role_policy   = data.aws_iam_policy_document.task_role_assume_policy.json
  name                 = "example.${local.environment}"
  permissions_boundary = data.aws_iam_policy.default_boundary.arn
  tags                 = var.default_tags
}
```

Define the boundary data source:

```hcl
data "aws_iam_policy" "default_boundary" {
  name = "${local.service_name}-non-ci-boundary"
}
```

At this stage, resolve any permission issues by updating the allowed actions within your service boundary.

Once this change is deployed to production and stable, proceed to the next stage.

---

## Stage 3: Gradual CI Role Transition

You have two options:

### Option A: Full Switch
Switch all environments to use the boundaried CI role at once.

### Option B: Gradual Rollout (Recommended)
Test the new boundaried CI role in development first.

Override the default role in development environments using an environment variable:

```bash
TF_VAR_DEFAULT_ROLE=<service>-ci-boundary
```

This can be injected via your CI/CD pipeline configuration.

---

## Stage 4: Remove Legacy CI Roles

Once all environments are successfully using the boundaried CI roles, disable the legacy (non-boundaried) CI roles:

```hcl
ci_classic_enabled = false
```

---

## Notes

- Ensure all required permissions are included in the service boundary before rollout.
- Prefer gradual rollout in lower environments to reduce risk.
- Monitor for permission issues after each stage before proceeding.

---
``
