# Cisco DevNet Create

## Premise

- You have Consul, which serves as a catalog of services
  in your environment.

- You use Terraform to configure Cisco ACI as code.

## Problem

How do you synchronize the IP addresses from your service catalog
to Cisco ACI endpoint security groups?

## Criteria

1. Fully automated
1. Secure by default configuration for endpoint security groups

## Solution

- You can use the Consul-Terraform-Sync module
  [`CiscoDevNet/esg-nia`](https://registry.terraform.io/modules/CiscoDevNet/esg-nia/aci/latest)
  to create endpoint security groups based on the service catalog.

- You can build security testing into module development.

## Demo

You notice a few important configurations that should be there, but
aren't!

