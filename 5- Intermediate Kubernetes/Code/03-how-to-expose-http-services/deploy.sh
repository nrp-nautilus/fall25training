#!/bin/bash

# Deploy HTTP service with ingress
# This script deploys a simple HTTP service and exposes it via ingress

echo "Deploying HTTP pod..."
kubectl apply -f pod.yaml

echo "Waiting for pod to be ready..."
kubectl wait --for=condition=Ready pod/my-http-pod --timeout=60s

echo "Deploying service..."
kubectl apply -f service.yaml

echo "Deploying ingress..."
kubectl apply -f ingress.yaml

echo "Testing service locally..."
kubectl port-forward service/test-svc 8080:8080 &
PORT_FORWARD_PID=$!

sleep 5
echo "Testing local connection..."
curl http://localhost:8080/

echo "Cleaning up port forward..."
kill $PORT_FORWARD_PID

echo "Deployment completed!"
echo "Your service will be available at: https://test-service.nrp-nautilus.io"
echo "Note: It may take a few minutes for the ingress to be fully configured"
