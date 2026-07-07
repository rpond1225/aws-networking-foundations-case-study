# VPC Design

## Objective

Create a Virtual Private Cloud (VPC) that provides a secure, scalable network foundation for AWS resources.

## Design Goals

- Isolate resources from the public internet.
- Control inbound and outbound traffic.
- Separate public-facing resources from internal workloads.
- Allow future expansion without redesigning the network.
- Support multiple Availability Zones.
- Prepare for future VPC peering and hybrid networking.

## Why a VPC?

Amazon VPC provides a logically isolated virtual network within AWS.

Unlike a traditional on-premises network, AWS allows the network architecture to be defined in software. Every subnet, route table, security group, and gateway is created as infrastructure rather than physical hardware.

This makes the network repeatable, version controlled, and deployable using Infrastructure as Code.