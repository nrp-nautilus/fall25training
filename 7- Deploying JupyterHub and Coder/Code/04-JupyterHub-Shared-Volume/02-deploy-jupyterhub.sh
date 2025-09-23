#!/bin/bash
# Generate secret token
SECRET_TOKEN=$(openssl rand -hex 32)


sed -i.bak "s/REPLACE_WITH_GENERATED_TOKEN/$SECRET_TOKEN/g" 01-jupyterhub-config.yaml


helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/ 2>/dev/null || true
helm repo update

kubectl apply -f 01-shared-volume-pvc.yaml

kubectl wait --for=condition=Bound pvc/jupyterhub-shared-volume -n training-test-to-delete-later --timeout=60s

helm upgrade --cleanup-on-fail --install jhub-shared jupyterhub/jupyterhub \
    --namespace training-test-to-delete-later \
    --version=3.3.7 \
    --values 01-jupyterhub-config.yaml \
    --wait \
    --timeout=10m
# Check deployment status
kubectl get pods -n training-test-to-delete-later
kubectl get pvc -n training-test-to-delete-later