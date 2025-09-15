#!/bin/bash

# Create CephFS PVC
kubectl create -f 03-cephfs-pvc.yaml

# Wait for PVC to be bound
kubectl wait --for=condition=Bound pvc/cephfs-pvc --timeout=60s

# Check PVC status
kubectl get pvc

# Create CephFS pod
kubectl create -f 04-cephfs-pod.yaml

# Wait for pod to be ready
kubectl wait --for=condition=Ready pod/cephfs-pod --timeout=60s

# Check pod status
kubectl get pods -o wide

# Test CephFS storage
kubectl exec cephfs-pod -- touch /shared-data/shared-file.txt
kubectl exec cephfs-pod -- ls -la /shared-data

# To log into pod: kubectl exec -it cephfs-pod -- /bin/bash
# To delete: kubectl delete pod cephfs-pod && kubectl delete pvc cephfs-pvc
