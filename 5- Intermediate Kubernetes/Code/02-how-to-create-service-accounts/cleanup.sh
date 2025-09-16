#!/bin/bash

# Clean up service account resources
# This script removes the service account and related resources

# Set the service account name
SERVICE_ACCOUNT_NAME="my-script-sa"

echo "Cleaning up service account: $SERVICE_ACCOUNT_NAME"

# Delete the role binding
kubectl delete rolebinding ${SERVICE_ACCOUNT_NAME}-sa 2>/dev/null || echo "Role binding not found"

# Delete the service account (this will also delete the secret)
kubectl delete serviceaccount $SERVICE_ACCOUNT_NAME 2>/dev/null || echo "Service account not found"

# Remove the config file
rm -f ~/.kube/config_sa

echo "Cleanup completed!"
