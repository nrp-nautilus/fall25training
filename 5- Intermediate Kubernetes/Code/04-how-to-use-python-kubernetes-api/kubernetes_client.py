#!/usr/bin/env python3

# Python Kubernetes client example
# This script demonstrates how to use the Python Kubernetes client library

from kubernetes import client, config
import sys
import urllib3

# Disable SSL warnings for this example
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

def main():
    # Load Kubernetes configuration
    # This will load from ~/.kube/config or from the service account token
    try:
        config.load_incluster_config()
        print("Loaded in-cluster config")
    except:
        try:
            config.load_kube_config()
            print("Loaded kube config")
        except Exception as e:
            print(f"Failed to load config: {e}")
            sys.exit(1)

    # Create API client with SSL verification disabled for this example
    configuration = client.Configuration()
    configuration.verify_ssl = False
    v1 = client.CoreV1Api(client.ApiClient(configuration))

    # List all pods in the current namespace
    print("\n=== Pods in current namespace ===")
    try:
        pods = v1.list_pod_for_all_namespaces()
        for pod in pods.items:
            print(f"Pod: {pod.metadata.name} in namespace: {pod.metadata.namespace}")
    except Exception as e:
        print(f"Error listing pods: {e}")

    # List all services
    print("\n=== Services ===")
    try:
        services = v1.list_service_for_all_namespaces()
        for service in services.items:
            print(f"Service: {service.metadata.name} in namespace: {service.metadata.namespace}")
    except Exception as e:
        print(f"Error listing services: {e}")

    # List all namespaces
    print("\n=== Namespaces ===")
    try:
        namespaces = v1.list_namespace()
        for namespace in namespaces.items:
            print(f"Namespace: {namespace.metadata.name}")
    except Exception as e:
        print(f"Error listing namespaces: {e}")

if __name__ == "__main__":
    main()
