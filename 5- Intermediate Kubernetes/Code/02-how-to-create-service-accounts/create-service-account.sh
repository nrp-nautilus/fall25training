#!/bin/bash

# Create a service account for client scripts
# This script creates a service account and generates a token for Kubernetes API access

# Set the service account name
SERVICE_ACCOUNT_NAME="my-script-sa"

echo "Creating service account: $SERVICE_ACCOUNT_NAME"

# Create the service account
kubectl create serviceaccount $SERVICE_ACCOUNT_NAME

# Create a secret for the service account token
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: ${SERVICE_ACCOUNT_NAME}-secret
  annotations:
    kubernetes.io/service-account.name: ${SERVICE_ACCOUNT_NAME}
type: kubernetes.io/service-account-token
EOF

# Retrieve the token
TOKEN=`kubectl get secret ${SERVICE_ACCOUNT_NAME}-secret -o jsonpath='{.data.token}'| base64 --decode`
echo "Token retrieved: ${TOKEN:0:20}..."

# Copy current config and create service account config
cp ~/.kube/config ~/.kube/config_sa

# Remove existing user from the copied config
kubectl --kubeconfig=~/.kube/config_sa config unset users.$(kubectl --kubeconfig=~/.kube/config_sa config view -o jsonpath='{.users[0].name}')

# Set credentials for the service account
kubectl --kubeconfig=~/.kube/config_sa config set-credentials $SERVICE_ACCOUNT_NAME --token=$TOKEN

# Set context to use the service account
kubectl --kubeconfig=~/.kube/config_sa config set-context --current --user=$SERVICE_ACCOUNT_NAME

echo "Service account config created at ~/.kube/config_sa"
echo "You can now use this config for your scripts:"
echo "export KUBECONFIG=~/.kube/config_sa"