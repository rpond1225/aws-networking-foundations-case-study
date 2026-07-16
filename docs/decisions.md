# Engineering Decisions

| Property | Value |
|----------|-------|
| Case Study | CAL-001 — AWS Networking Foundations |
| Status | Current |
| Last Updated | 2026-07-15 |

---

# Overview

This document summarizes the significant engineering decisions made during the development of CAL-001.

Detailed decision records are maintained separately as Architecture Decision Records (ADRs). This document provides a concise overview of the reasoning that shaped the current implementation.

---

# Networking Foundation First

## Decision

Build the networking foundation before deploying compute resources.

## Rationale

Networking is a prerequisite for nearly every AWS workload. Establishing a reusable, validated foundation allows future case studies to focus on new architectural concepts without rebuilding core networking components.

---

# Infrastructure as Code

## Decision

Manage all infrastructure using Terraform.

## Rationale

Terraform provides repeatable deployments, version control, and consistent environments while reducing manual configuration.

---

# Incremental Delivery

## Decision

Develop the environment through small, validated milestones.

## Rationale

Each milestone introduces a limited number of concepts, making it easier to understand, validate, and document architectural changes.

---

# Public and Private Network Segmentation

## Decision

Separate public and private resources into dedicated subnets.

## Rationale

Network segmentation improves security and reflects common AWS architectural patterns used in production environments.

---

# Security Group References

## Decision

Use Security Group references between application tiers.

## Rationale

Referencing Security Groups instead of IP addresses simplifies scaling and reduces administrative overhead while maintaining least-privilege access.

---

# Multi-Availability Zone Design

## Decision

Design Terraform for future multi-Availability Zone expansion using `for_each`.

## Rationale

Although the current deployment uses a single Availability Zone, the Terraform configuration supports future expansion with minimal structural changes.

---

# Architecture as Code

## Decision

Maintain architecture diagrams as version-controlled Mermaid source.

## Rationale

Treating architecture diagrams as source code enables version control, peer review, and synchronization with the deployed environment.

---

# Documentation as an Engineering Deliverable

## Decision

Separate documentation into focused engineering documents.

## Rationale

Keeping architecture, deployment, validation, and engineering decisions in dedicated documents improves maintainability and reduces duplication.

---

# Related ADRs

Additional implementation details are documented in:

- `adr/`

---

# Related Documentation

- `architecture.md`
- `deployment.md`
- `validation.md`