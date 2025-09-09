#!/bin/bash

# Create HTTP deployment
kubectl create -f 01-http-deployment.yaml

# Wait for deployment to be ready
kubectl wait --for=condition=Available deployment/test-http --timeout=120s

# Check deployment status
kubectl get deployments
kubectl get pods -o wide

# Scale deployment to 3 replicas
kubectl scale deployment test-http --replicas=3

# Check scaled deployment
kubectl get pods -o wide

# Scale back to 2 replicas
kubectl scale deployment test-http --replicas=2

# To delete deployment: kubectl delete deployment test-http
