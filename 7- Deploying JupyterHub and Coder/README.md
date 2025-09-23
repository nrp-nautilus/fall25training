# Session 7: Deploying JupyterHub

**Target Audience:** NS Admin/PI, Instructors (Not for Beginner or Accustomed Users)  
**Date:** Tuesday, September 23, 2025  
**Time:** 10:00 AM PDT / 1:00 PM EDT  
**Status:** ✅ Ready  
**Recording:** Coming soon

## Overview
Learn how to deploy and manage JupyterHub environments for groups or courses. This tutorial covers deploying multi-user environments with proper authentication, resource management, mandatory culling policies, and multiple image profiles.

## Learning Objectives
- Install and configure Helm package manager
- Deploy JupyterHub with password authentication (simplified for tutorial)
- Configure mandatory culling policies for NRP compliance
- Set up multiple image profiles for different use cases
- Configure ingress for external access
- Manage and clean up deployments properly

## Prerequisites
- Access to NRP cluster
- kubectl configured and authenticated
- Basic understanding of Kubernetes concepts
- Terminal access

## Structure
- `Slides/` - Coming Soon
- `Code/` - Deployment configurations, management scripts
  - `01-install-helm/` - Helm installation
  - `02-jupyterhub-deployment/` - JupyterHub deployment with culling and multiple profiles

## Quick Start

### 1. Install Helm
```bash
cd 01-install-helm/
chmod +x 01-install-helm.sh
./01-install-helm.sh
```

### 2. Deploy JupyterHub
```bash
cd 02-jupyterhub-deployment/
chmod +x *.sh

# Option A: Complete automated test
./10-complete-test.sh

# Option B: Manual step-by-step
# Generate secret token
./02-generate-secret.sh
# Copy generated token to 03-jupyterhub-config.yaml

# Deploy JupyterHub
./04-add-helm-repo.sh
./05-deploy-jupyterhub.sh

# Check deployment
kubectl get pods -n training-test-to-delete-later
```

### 3. Access JupyterHub
```bash
# Access via port-forward (for testing)
./06-access-jupyterhub.sh
# Open http://localhost:8080, login: admin/training123

# Check ingress configuration
./11-check-ingress.sh

# Access via ingress (if configured)
# Open https://training-test.nrp-nautilus.io
```

## Important Notes
- **Culling is Mandatory**: All JupyterHub deployments MUST include culling configuration with maximum idle time of 6 hours or less
- **Test Namespace**: Use `training-test-to-delete-later` namespace for testing
- **Cleanup Required**: Always clean up resources after testing
- **Password Authentication**: This tutorial uses simple password auth for ease of following; production deployments should use CILogon
- **Multiple Profiles**: Includes 8 different Jupyter image profiles (Scipy, R, Julia, Tensorflow, PyTorch, etc.)
- **Ingress Configuration**: Configured for external access via `training-test.nrp-nautilus.io`

## Available Image Profiles
- **Scipy** (default) - Scientific Python stack
- **R** - R statistical computing
- **Julia** - Julia programming language
- **Tensorflow** - Deep learning with TensorFlow
- **PyTorch** - Deep learning with PyTorch
- **Datascience** - Combined scipy, Julia, R
- **Pyspark** - Apache Spark with Python
- **All Spark** - Complete Spark ecosystem

## Resources
- [NRP Training Schedule](https://nrp.ai/training/)
- [JupyterHub Documentation](https://nrp.ai/documentation/userdocs/jupyter/jupyterhub/)
- Educational environment deployment and management
