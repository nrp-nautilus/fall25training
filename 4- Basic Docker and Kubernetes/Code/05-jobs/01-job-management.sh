#!/bin/bash

# Create simple job
kubectl create -f 01-simple-job.yaml

# Wait for job to complete
kubectl wait --for=condition=Complete job/simple-job --timeout=60s

# Check job status
kubectl get jobs
kubectl get pods -l job-name=simple-job

# Show job logs
kubectl logs job/simple-job

# To delete job: kubectl delete job simple-job
