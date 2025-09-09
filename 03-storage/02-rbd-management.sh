#!/bin/bash

# Create RBD PVC
kubectl create -f 01-rbd-pvc.yaml

# Wait for PVC to be bound
kubectl wait --for=condition=Bound pvc/rbd-pvc --timeout=60s

# Check PVC status
kubectl get pvc

# Create RBD pod
kubectl create -f 02-rbd-pod.yaml

# Wait for pod to be ready
kubectl wait --for=condition=Ready pod/rbd-pod --timeout=60s

# Check pod status
kubectl get pods -o wide

# Test RBD storage
kubectl exec rbd-pod -- touch /data/test-file.txt
kubectl exec rbd-pod -- ls -la /data

# To log into pod: kubectl exec -it rbd-pod -- /bin/bash
# To delete: kubectl delete pod rbd-pod && kubectl delete pvc rbd-pvc
