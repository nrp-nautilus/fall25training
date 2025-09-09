#!/bin/bash

# Create parallel job
kubectl create -f 04-parallel-job.yaml

# Wait for job to complete
kubectl wait --for=condition=Complete job/parallel-job --timeout=180s

# Check job status
kubectl get jobs
kubectl get pods -l job-name=parallel-job

# Show job logs from all pods
kubectl logs job/parallel-job

# Show individual pod logs
kubectl get pods -l job-name=parallel-job -o name | xargs -I {} kubectl logs {}

# To delete job: kubectl delete job parallel-job
