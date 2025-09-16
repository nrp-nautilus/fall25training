#!/bin/bash

# Deploy Dask cluster
# This script deploys a Dask cluster with scheduler and worker nodes

echo "Deploying Dask cluster..."

# Deploy scheduler
echo "Deploying Dask scheduler..."
kubectl apply -f dask-scheduler.yaml

echo "Waiting for scheduler to be ready..."
kubectl wait --for=condition=Ready pod/dask-scheduler --timeout=120s

# Deploy service
echo "Deploying Dask service..."
kubectl apply -f dask-service.yaml

# Deploy worker
echo "Deploying Dask worker..."
kubectl apply -f dask-worker.yaml

echo "Waiting for worker to be ready..."
kubectl wait --for=condition=Ready pod/dask-worker --timeout=120s

echo "Setting up port forwarding for Dask dashboard..."
kubectl port-forward service/dask-service 8787:8787 &
PORT_FORWARD_PID=$!

echo "Dask cluster is ready!"
echo "Dashboard available at: http://localhost:8787"
echo "Scheduler available at: dask-scheduler:8786"
echo "Press Ctrl+C to stop the port forward"

# Wait for user to stop
wait $PORT_FORWARD_PID
