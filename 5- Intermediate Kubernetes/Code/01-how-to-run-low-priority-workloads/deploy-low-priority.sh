#!/bin/bash

# Deploy low priority workloads
# This script demonstrates how to run pods and jobs with low priority

echo "Deploying low priority pod..."
kubectl apply -f low-priority-pod.yaml

echo "Waiting for pod to be ready..."
kubectl wait --for=condition=Ready pod/low-priority-pod --timeout=60s

echo "Deploying low priority job..."
kubectl apply -f low-priority-job.yaml

echo "Waiting for job to complete..."
kubectl wait --for=condition=complete job/low-priority-job --timeout=120s

echo "Checking pod status..."
kubectl get pods -o wide

echo "Checking job status..."
kubectl get jobs

echo "Checking job logs..."
kubectl logs job/low-priority-job

echo "Low priority workloads deployed successfully!"
echo "These workloads will be preempted by higher priority workloads when resources are scarce."
