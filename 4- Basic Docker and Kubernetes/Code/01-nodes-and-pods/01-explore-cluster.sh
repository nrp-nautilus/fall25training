#!/bin/bash

# List cluster nodes
kubectl get nodes

# List pods in current namespace
kubectl get pods

# List deployments in current namespace (if any)
kubectl get deployments

# List services in current namespace
kubectl get services

# Get detailed pod information
kubectl get pods -o wide

# Check recent events
kubectl get events --sort-by=.metadata.creationTimestamp