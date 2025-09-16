#!/bin/bash

# Deploy Selkies GUI Desktop
# This script deploys a desktop environment accessible via web browser

echo "Deploying Selkies GUI Desktop..."

# Deploy the pod
kubectl apply -f selkies-cpu.yaml

echo "Waiting for pod to be ready..."
kubectl wait --for=condition=Ready pod/selkies-desktop-cpu --timeout=120s

# Deploy the service
kubectl apply -f selkies-service.yaml

echo "Setting up port forwarding..."
kubectl port-forward service/selkies-desktop-service 8080:8080 &
PORT_FORWARD_PID=$!

echo "Desktop environment is starting up..."
echo "Once ready, you can access it at: http://localhost:8080"
echo "Press Ctrl+C to stop the port forward"

# Wait for user to stop
wait $PORT_FORWARD_PID
