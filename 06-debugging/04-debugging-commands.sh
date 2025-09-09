#!/bin/bash

# List all pods with status
kubectl get pods --all-namespaces

# List pods with more details
kubectl get pods -o wide

# Get pod status with custom columns
kubectl get pods -o custom-columns=NAME:.metadata.name,STATUS:.status.phase,READY:.status.containerStatuses[0].ready,RESTARTS:.status.containerStatuses[0].restartCount

# Get all events
kubectl get events --sort-by=.metadata.creationTimestamp

# Get events for specific namespace
kubectl get events -n default

# Check node resources
kubectl top nodes

# Check pod resources
kubectl top pods

# Get cluster info
kubectl cluster-info

# Get node info
kubectl get nodes -o wide

# Check storage
kubectl get pv,pvc

# Check services
kubectl get services

# Check deployments
kubectl get deployments
