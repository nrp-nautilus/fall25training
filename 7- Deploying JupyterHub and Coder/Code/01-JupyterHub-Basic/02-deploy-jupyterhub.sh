#!/bin/bash

# Generate secret token
SECRET_TOKEN=$(openssl rand -hex 32)

# Add Helm repository
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/ 2>/dev/null || true
helm repo update

# Deploy JupyterHub basic configuration
helm upgrade --cleanup-on-fail --install jhub-basic jupyterhub/jupyterhub \
    --namespace training-test-to-delete-later \
    --version=3.3.7 \
    --values 03-jupyterhub-config.yaml \
    --wait \
    --timeout=10m

# Check deployment status
kubectl get pods -n training-test-to-delete-later
