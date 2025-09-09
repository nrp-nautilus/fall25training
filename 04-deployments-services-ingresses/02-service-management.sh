#!/bin/bash

# Create service
kubectl create -f 03-service.yaml

# Check service status
kubectl get services

# Create curl pod for testing
kubectl create -f 02-curl-pod.yaml

# Wait for curl pod to be ready
kubectl wait --for=condition=Ready pod/test-curl-pod --timeout=60s

# Get service IP
kubectl get service test-svc

# Test service from curl pod
kubectl exec test-curl-pod -- curl http://test-svc

# Test multiple times to see load balancing
kubectl exec test-curl-pod -- curl http://test-svc
kubectl exec test-curl-pod -- curl http://test-svc

# To log into curl pod: kubectl exec -it test-curl-pod -- /bin/sh
# To delete: kubectl delete service test-svc && kubectl delete pod test-curl-pod
