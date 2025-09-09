#!/bin/bash

# Create failing pod
kubectl create -f 01-failing-pod.yaml

# Wait for pod to fail
sleep 10

# Check pod status
kubectl get pods

# Get pod logs
kubectl logs failing-pod

# Get previous logs if pod restarted
kubectl logs failing-pod --previous

# Get logs with timestamps
kubectl logs failing-pod --timestamps

# Follow logs in real-time (for running pods)
# kubectl logs -f pod-name

# To delete pod: kubectl delete pod failing-pod
