# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0


# This file is used to specify the required providers(azuread) for this configuration.
terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.41.0"
    }
  }
}