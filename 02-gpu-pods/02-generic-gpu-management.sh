#!/bin/bash

# Create generic GPU pod
kubectl create -f 01-generic-gpu-pod.yaml

# Wait for the pod to be ready
kubectl wait --for=condition=Ready pod/generic-gpu-pod --timeout=300s

# Check pod status
kubectl get pods -l app=generic-gpu-pod

# Describe the pod for detailed information
kubectl describe pod generic-gpu-pod

# Log into the GPU container and run nvidia-smi
# kubectl exec -it generic-gpu-pod -c gpu-container -- nvidia-smi

# Clean up the generic GPU pod
kubectl delete -f 01-generic-gpu-pod.yaml
