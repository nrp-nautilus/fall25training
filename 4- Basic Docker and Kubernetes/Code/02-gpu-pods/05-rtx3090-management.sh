#!/bin/bash

# Discover nodes with RTX 3090 GPUs to confirm label
kubectl get nodes -L nvidia.com/gpu.product | grep "NVIDIA-GeForce-RTX-3090"

# Create RTX 3090 GPU pod
kubectl create -f 04-rtx3090-pod.yaml

# Wait for the pod to be ready
kubectl wait --for=condition=Ready pod/rtx3090-gpu-pod --timeout=300s

# Check pod status
kubectl get pods -l app=rtx3090-gpu-pod

# Describe the pod for detailed information
kubectl describe pod rtx3090-gpu-pod

# Log into the GPU container and run nvidia-smi
# kubectl exec -it rtx3090-gpu-pod -c gpu-container -- nvidia-smi

# Clean up the RTX 3090 GPU pod
kubectl delete -f 04-rtx3090-pod.yaml
