#!/bin/bash

# Create CPU job
kubectl create -f 02-cpu-job.yaml

# Wait for job to complete
kubectl wait --for=condition=Complete job/cpu-job --timeout=120s

# Check job status
kubectl get jobs
kubectl get pods -l job-name=cpu-job

# Show job logs
kubectl logs job/cpu-job

# To delete job: kubectl delete job cpu-job
