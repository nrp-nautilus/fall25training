#!/bin/bash

# Generate secret token
SECRET_TOKEN=$(openssl rand -hex 32)

# Update config with generated token
sed -i.bak "s/REPLACE_WITH_GENERATED_TOKEN/$SECRET_TOKEN/g" 01-jupyterhub-config.yaml

# Add Helm repository
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/ 2>/dev/null || true
helm repo update

# Deploy JupyterHub with spawner options
helm upgrade --cleanup-on-fail --install jhub-spawner jupyterhub/jupyterhub \
    --namespace training-test-to-delete-later \
    --version=3.3.7 \
    --values 01-jupyterhub-config.yaml \
    --wait \
    --timeout=10m

# Check deployment status
kubectl get pods -n training-test-to-delete-later
