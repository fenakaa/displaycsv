#!/bin/bash
# create_infra.sh - Cria Resource Group, App Service Plan (Linux B1) e WebApp Python 3.12
# Uso: editar as variaveis abaixo antes de executar ou exportar as variaveis no shell.

set -euo pipefail

# ====== Variáveis (edite aqui) ======
RESOURCE_GROUP="rg-gscloud"
LOCATION="brazilsouth"
PLAN_NAME="plan-gscloud-b1"
WEBAPP_NAME="webappgs"       # nome do webapp (único globalmente)
PYTHON_VERSION="3.12"
SKU="B1"
# ====================================

echo "Checando se az está logado..."
az account show > /dev/null || { echo "Por favor faça az login antes de executar (ou use Cloud Shell)"; exit 1; }

echo "Criando Resource Group: $RESOURCE_GROUP em $LOCATION ..."
az group create --name "$RESOURCE_GROUP" --location "$LOCATION"

echo "Criando App Service Plan (Linux, $SKU) : $PLAN_NAME ..."
az appservice plan create \
  --name "$PLAN_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --is-linux \
  --sku "$SKU"

echo "Criando WebApp: $WEBAPP_NAME (runtime PYTHON:$PYTHON_VERSION) ..."
az webapp create \
  --resource-group "$RESOURCE_GROUP" \
  --plan "$PLAN_NAME" \
  --name "$WEBAPP_NAME" \
  --runtime "PYTHON:$PYTHON_VERSION"

echo "Configurando extensão optional: habilitando construção via Oryx (opcional)"
# Exemplo opcional de configuração, comente se não quiser:
# az webapp config set --resource-group "$RESOURCE_GROUP" --name "$WEBAPP_NAME" --linux-fx-version "PYTHON|$PYTHON_VERSION"

echo "Infra criada. URL do WebApp:"
az webapp show --resource-group "$RESOURCE_GROUP" --name "$WEBAPP_NAME" --query defaultHostName -o tsv | awk '{print "https://"$0}'
echo "Terminado."
