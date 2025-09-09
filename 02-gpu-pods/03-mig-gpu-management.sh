#!/bin/bash

# Create MIG GPU pod
kubectl create -f 02-mig-gpu-pod.yaml

# Wait for the pod to be ready
kubectl wait --for=condition=Ready pod/mig-gpu-pod --timeout=300s

# Check pod status
kubectl get pods -l app=mig-gpu-pod

# Describe the pod for detailed information
kubectl describe pod mig-gpu-pod

# Log into the MIG GPU container and run nvidia-smi
# kubectl exec -it mig-gpu-pod -c mig-gpu-container -- nvidia-smi

# Clean up the MIG GPU pod
kubectl delete -f 02-mig-gpu-pod.yaml
