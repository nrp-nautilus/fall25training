#!/bin/bash

# Test the service account connection
# This script tests if the service account can connect to Kubernetes

echo "Testing service account connection..."

# Set the service account name
SERVICE_ACCOUNT_NAME="my-script-sa"

# Test if we can list pods
echo "Testing pod listing..."
kubectl --kubeconfig=~/.kube/config_sa get pods

# Test if we can list services
echo "Testing service listing..."
kubectl --kubeconfig=~/.kube/config_sa get services

# Test if we can list namespaces
echo "Testing namespace listing..."
kubectl --kubeconfig=~/.kube/config_sa get namespaces

echo "Connection test completed!"
