#!/bin/bash

# Automatically fetch the active KodeKloud resource group name for this session
RESOURCE_GROUP_NAME=$(az group list --query "[0].name" -o tsv)

STORAGE_ACCOUNT_NAME="nagastatefile"
CONTAINER_NAME="tfstate"

echo "Using active Resource Group: $RESOURCE_GROUP_NAME"

# 1. Create storage account
echo "Creating storage account..."
az storage account create \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --name "$STORAGE_ACCOUNT_NAME" \
  --sku Standard_LRS \
  --encryption-services blob \
  --allow-blob-public-access false

# --- ADDED: Wait for Azure to register the new storage account ---
echo "Waiting 15 seconds for storage account propagation..."
sleep 15

# 2. Create blob container
echo "Creating blob container..."
az storage container create \
  --name "$CONTAINER_NAME" \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --auth-mode login

echo "Setup complete! Your storage account and container are ready."