#!/bin/bash

# Create multi-container pod
kubectl create -f 03-multi-container-pod.yaml

# Wait for pod to be ready
kubectl wait --for=condition=Ready pod/multi-container-pod --timeout=60s

# Check pod status
kubectl get pods

# Get detailed pod information
kubectl describe pod multi-container-pod

# Check pod IP (shared by both containers)
kubectl get pod -o wide multi-container-pod

# Log into web-server container
echo "Logging into web-server container:"
kubectl exec -it multi-container-pod -c web-server -- /bin/bash

# Log into sidecar container (in another terminal)
echo "To log into sidecar container: kubectl exec -it multi-container-pod -c sidecar -- /bin/sh"

# Check logs from both containers
echo "Web-server logs:"
kubectl logs multi-container-pod -c web-server

echo "Sidecar logs:"
kubectl logs multi-container-pod -c sidecar

# To delete pod: kubectl delete pod multi-container-pod
