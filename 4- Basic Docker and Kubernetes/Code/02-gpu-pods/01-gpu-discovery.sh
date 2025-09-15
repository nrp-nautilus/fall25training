#!/bin/bash

# List all nodes with GPU product labels
kubectl get nodes -L nvidia.com/gpu.product

# List all nodes with CUDA driver and runtime versions
kubectl get nodes -L nvidia.com/cuda.driver.major,nvidia.com/cuda.driver.minor,nvidia.com/cuda.runtime.major,nvidia.com/cuda.runtime.minor -l nvidia.com/gpu.product

# Count available GPU types
kubectl get nodes -L nvidia.com/gpu.product --no-headers | awk '{print $NF}' | sort | uniq -c

# Find nodes with RTX 3090 GPUs
kubectl get nodes -l nvidia.com/gpu.product=NVIDIA-GeForce-RTX-3090

# Find nodes with A100 MIG 1g.10gb GPUs
kubectl get nodes -l nvidia.com/mig-small
