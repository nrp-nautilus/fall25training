#!/bin/bash

# Clean up low priority workloads
# This script removes all low priority resources

echo "Cleaning up low priority workloads..."

echo "Deleting low priority pod..."
kubectl delete pod low-priority-pod 2>/dev/null || echo "Pod not found"

echo "Deleting low priority job..."
kubectl delete job low-priority-job 2>/dev/null || echo "Job not found"


echo "Cleanup completed!"
