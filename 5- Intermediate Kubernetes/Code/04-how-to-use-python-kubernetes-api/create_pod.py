#!/usr/bin/env python3

# Create a pod using Python Kubernetes client
# This script creates a simple nginx pod using the Python API

from kubernetes import client, config
import sys
import urllib3

# Disable SSL warnings for this example
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

def main():
    # Load Kubernetes configuration
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

    # Define the pod
    pod_manifest = {
        "apiVersion": "v1",
        "kind": "Pod",
        "metadata": {
            "name": "python-created-pod",
            "labels": {
                "app": "python-test"
            }
        },
        "spec": {
            "containers": [
                {
                    "name": "nginx",
                    "image": "nginx:latest",
                    "ports": [
                        {
                            "containerPort": 80
                        }
                    ]
                }
            ]
        }
    }

    # Create the pod
    print("Creating pod...")
    try:
        pod = v1.create_namespaced_pod(
            namespace="mfsada",
            body=pod_manifest
        )
        print(f"Pod created: {pod.metadata.name}")
    except Exception as e:
        print(f"Error creating pod: {e}")
        sys.exit(1)

    # Wait for pod to be ready
    print("Waiting for pod to be ready...")
    try:
        v1.wait_for_namespaced_pod(
            name="python-created-pod",
            namespace="mfsada",
            timeout=60
        )
        print("Pod is ready!")
    except Exception as e:
        print(f"Error waiting for pod: {e}")

    # Get pod status
    try:
        pod = v1.read_namespaced_pod(
            name="python-created-pod",
            namespace="mfsada"
        )
        print(f"Pod status: {pod.status.phase}")
    except Exception as e:
        print(f"Error getting pod status: {e}")

if __name__ == "__main__":
    main()
