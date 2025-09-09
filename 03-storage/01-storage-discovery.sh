#!/bin/bash

# List available storage classes
kubectl get storageclass

# List existing PVCs
kubectl get pvc

# Check storage usage
kubectl get pvc -o custom-columns=NAME:.metadata.name,STATUS:.status.phase,VOLUME:.spec.volumeName,CAPACITY:.status.capacity.storage,STORAGECLASS:.spec.storageClassName
