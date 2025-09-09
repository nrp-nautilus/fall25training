#!/bin/bash

# Create resource pod
kubectl create -f 03-resource-pod.yaml

# Wait for pod to be ready
kubectl wait --for=condition=Ready pod/resource-pod --timeout=60s

# Get detailed pod information
kubectl describe pod resource-pod

# Get pod YAML
kubectl get pod resource-pod -o yaml

# Get pod events
kubectl get events --field-selector involvedObject.name=resource-pod

# Get pod resource usage
kubectl top pod resource-pod

# Get pod with wide output
kubectl get pod resource-pod -o wide

# To delete pod: kubectl delete pod resource-pod
