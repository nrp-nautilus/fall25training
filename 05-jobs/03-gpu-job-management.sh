#!/bin/bash

# Create GPU job
kubectl create -f 03-gpu-job.yaml

# Wait for job to complete
kubectl wait --for=condition=Complete job/gpu-job --timeout=120s

# Check job status
kubectl get jobs
kubectl get pods -l job-name=gpu-job

# Show job logs
kubectl logs job/gpu-job

# To delete job: kubectl delete job gpu-job
