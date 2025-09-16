#!/usr/bin/env python3

# Test Python Kubernetes client setup
# This script tests if the Python Kubernetes client is properly installed

try:
    from kubernetes import client, config
    print("✅ Kubernetes Python client is installed")
    print(f"   Version: {client.__version__}")
except ImportError as e:
    print("❌ Kubernetes Python client is not installed")
    print("   Install with: pip install kubernetes")
    exit(1)

try:
    import urllib3
    print("✅ urllib3 is available for SSL handling")
except ImportError as e:
    print("❌ urllib3 is not available")
    print("   Install with: pip install urllib3")

print("\n📝 To use the Python Kubernetes client:")
print("   1. Make sure you have kubectl configured")
print("   2. Run: python3 kubernetes_client.py")
print("   3. Or run: python3 create_pod.py")
print("\n💡 Note: These scripts require access to a Kubernetes cluster")
print("   They will work when run from within the cluster or with proper kubeconfig")