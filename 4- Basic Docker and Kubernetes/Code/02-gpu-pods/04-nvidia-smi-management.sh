#!/bin/bash

# Create nvidia-smi job
kubectl create -f 03-nvidia-smi-job.yaml

# Wait for the job to complete
kubectl wait --for=condition=complete job/nvidia-smi-job --timeout=300s

# Get job logs
kubectl logs jobs/nvidia-smi-job

# Clean up the job
kubectl delete job nvidia-smi-job
