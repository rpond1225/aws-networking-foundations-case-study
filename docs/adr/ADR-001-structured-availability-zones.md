# ADR-001 — Structured Availability Zone Configuration with `for_each`

## Status

**Accepted**

---

## Context

The initial implementation of CAL-001 considered defining the networking configuration using individual Terraform variables:

```hcl
availability_zone
public_subnet_cidr
private_subnet_cidr
```

While this approach works for a single Availability Zone, it becomes increasingly difficult to maintain as the architecture grows.

Supporting an additional Availability Zone would require creating additional variables such as:

```hcl
availability_zone_2
public_subnet_cidr_2
private_subnet_cidr_2
```

This approach introduces several drawbacks:

- Variable names become repetitive and increasingly difficult to manage.
- Resource definitions would likely be duplicated for each Availability Zone.
- Expanding the architecture would require modifying Terraform code rather than simply updating configuration.
- Public and private subnet CIDRs are no longer naturally grouped with the Availability Zone they belong to.
- The configuration becomes less reusable for future Cloud Architect Lab case studies.

The project required a design that supports the current single-Availability Zone deployment while allowing future multi-AZ expansion without redesigning the Terraform configuration.

---

## Decision

Terraform will use a structured map of objects to define each participating Availability Zone and its associated subnet CIDR blocks.

```hcl
variable "availability_zones" {
  description = "Availability Zones and subnet CIDR blocks used by the VPC"

  type = map(object({
    public_subnet_cidr  = string
    private_subnet_cidr = string
  }))
}
```

The current deployment is configured as:

```hcl
availability_zones = {
  "us-east-1a" = {
    public_subnet_cidr  = "10.10.1.0/24"
    private_subnet_cidr = "10.10.11.0/24"
  }
}
```

Terraform resources use `for_each` to create one public subnet, one private subnet, and their associated networking resources for every configured Availability Zone.

Example:

```hcl
resource "aws_subnet" "public" {
  for_each = var.availability_zones

  vpc_id            = aws_vpc.main.id
  availability_zone = each.key
  cidr_block        = each.value.public_subnet_cidr
}
```

---

## Rationale

This design separates **environment configuration** from **infrastructure logic**.

The Terraform resource definitions describe *how* networking resources are created.

The `terraform.tfvars` file defines *where* they are created.

Each Availability Zone becomes a self-contained configuration object that groups its public and private subnet definitions together.

Adding another Availability Zone requires only another configuration entry.

Example:

```hcl
availability_zones = {
  "us-east-1a" = {
    public_subnet_cidr  = "10.10.1.0/24"
    private_subnet_cidr = "10.10.11.0/24"
  }

  "us-east-1b" = {
    public_subnet_cidr  = "10.10.2.0/24"
    private_subnet_cidr = "10.10.12.0/24"
  }
}
```

No changes to `main.tf` are required.

Terraform automatically creates:

- Public subnet
- Private subnet
- Public route table
- Private route table
- Route table associations

for every configured Availability Zone.

---

## Alternatives Considered

### Individual Variables

Example:

```hcl
availability_zone
public_subnet_cidr
private_subnet_cidr
```

This approach was rejected because it does not scale well beyond a single Availability Zone.

---

### Numbered Variables

Example:

```hcl
availability_zone_1
availability_zone_2
public_subnet_cidr_1
public_subnet_cidr_2
private_subnet_cidr_1
private_subnet_cidr_2
```

This approach was rejected because it produces repetitive variable definitions and requires ongoing Terraform code changes as the architecture grows.

---

### Duplicate Resource Blocks

Separate subnet and route table resources could have been written for each Availability Zone.

This approach was rejected because it duplicates infrastructure logic and reduces maintainability.

---

### Using `count`

Terraform's `count` meta-argument could also create multiple resources.

Resources would be addressed numerically:

```text
aws_subnet.public[0]
aws_subnet.public[1]
```

This approach was rejected because numeric indexes are less descriptive and can produce unnecessary resource-address changes when list ordering changes.

Using `for_each` produces stable, descriptive resource addresses:

```text
aws_subnet.public["us-east-1a"]
aws_subnet.public["us-east-1b"]
```

---

## Consequences

### Positive

- Supports future multi-Availability Zone expansion.
- Eliminates duplicate Terraform resource definitions.
- Keeps Availability Zone configuration grouped together.
- Produces stable Terraform resource addresses.
- Simplifies outputs by returning maps keyed by Availability Zone.
- Improves readability and maintainability.
- Demonstrates a scalable Terraform design pattern appropriate for enterprise Infrastructure as Code.

### Tradeoffs

- Introduces a more advanced Terraform data structure than simple string variables.
- Requires familiarity with `for_each`, `each.key`, and `each.value`.
- Changing an Availability Zone key causes Terraform to replace the associated resources.
- CIDR planning remains the responsibility of the configuration author.

---

## Future Considerations

This decision establishes the foundation for future multi-Availability Zone deployments.

Future milestones can expand the deployment simply by extending the `availability_zones` configuration.

A future multi-region architecture should use separate VPC module instances and region-specific AWS provider configurations rather than extending the current map across Regions.

---

## Validation

This design was validated by deploying the current single-Availability Zone configuration.

Terraform successfully created:

- One public subnet
- One private subnet
- One Internet Gateway
- One public route table
- One private route table
- Route table associations

The resulting Terraform resource addresses are keyed by Availability Zone, and a post-deployment `terraform plan` confirmed that the deployed infrastructure matches the Terraform configuration with no configuration drift.