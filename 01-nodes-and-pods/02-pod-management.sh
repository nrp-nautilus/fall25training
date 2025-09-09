#!/bin/bash

# Create single-container pod from YAML
kubectl create -f 02-pod1.yaml

# Wait for pod to be ready
kubectl wait --for=condition=Ready pod/test-pod --timeout=60s

# Check pod status
kubectl get pods

# Get detailed pod information
kubectl describe pod test-pod

# View pod logs
kubectl logs test-pod

# Get pod IP address
kubectl get pod -o wide test-pod

# To log into pod: kubectl exec -it test-pod -- /bin/bash
# To delete pod: kubectl delete pod test-pod