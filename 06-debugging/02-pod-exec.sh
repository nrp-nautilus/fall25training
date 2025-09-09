#!/bin/bash

# Create debug pod
kubectl create -f 02-debug-pod.yaml

# Wait for pod to be ready
kubectl wait --for=condition=Ready pod/debug-pod --timeout=60s

# Check pod status
kubectl get pods

# Execute commands in pod
kubectl exec debug-pod -- ps aux
kubectl exec debug-pod -- df -h
kubectl exec debug-pod -- env

# Execute interactive shell
# kubectl exec -it debug-pod -- /bin/bash

# Execute multiple commands
kubectl exec debug-pod -- sh -c "echo 'Current time:' && date && echo 'Uptime:' && uptime"

# Copy files to/from pod
# kubectl cp debug-pod:/path/to/file ./local-file
# kubectl cp ./local-file debug-pod:/path/to/file

# To delete pod: kubectl delete pod debug-pod
