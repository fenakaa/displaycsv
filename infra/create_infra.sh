#!/bin/bash

# Criar Resource Group
az group create \
  --name rg-f13 \
  --location brazilsouth

# Criar App Service Plan F1 Linux
az appservice plan create \
  --name asp-f13 \
  --resource-group rg-f13 \
  --sku F1 \
  --is-linux

# Criar WebApp Python 3.12 Linux
az webapp create \
  --resource-group rg-f13 \
  --plan asp-f13 \
  --name webapp-f13 \
  --runtime "PYTHON:3.12"
