#!/bin/bash

# Create ingress
kubectl create -f 04-ingress.yaml

# Check ingress status
kubectl get ingress

# Wait for ingress to be ready
kubectl wait --for=condition=Ready ingress/test-ingress --timeout=120s

# Get ingress details
kubectl describe ingress test-ingress

# Test ingress from curl pod
kubectl exec test-curl-pod -- curl http://test-service.nrp-nautilus.io

# Test HTTPS (if available)
kubectl exec test-curl-pod -- curl -k https://test-service.nrp-nautilus.io

# To delete: kubectl delete ingress test-ingress
