#!/bin/bash

# Deploy Ray cluster
# This script deploys a Ray cluster with head and worker nodes

echo "Deploying Ray cluster..."

# Deploy head node
echo "Deploying Ray head node..."
kubectl apply -f ray-head.yaml

echo "Waiting for head node to be ready..."
kubectl wait --for=condition=Ready pod/ray-head --timeout=120s

# Deploy service
echo "Deploying Ray service..."
kubectl apply -f ray-service.yaml

# Deploy worker node
echo "Deploying Ray worker node..."
kubectl apply -f ray-worker.yaml

echo "Waiting for worker node to be ready..."
kubectl wait --for=condition=Ready pod/ray-worker --timeout=120s

echo "Setting up port forwarding for Ray dashboard..."
kubectl port-forward service/ray-service 8265:8265 &
PORT_FORWARD_PID=$!

echo "Ray cluster is ready!"
echo "Dashboard available at: http://localhost:8265"
echo "Press Ctrl+C to stop the port forward"

# Wait for user to stop
wait $PORT_FORWARD_PID
