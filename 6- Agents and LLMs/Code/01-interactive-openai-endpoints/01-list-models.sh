#!/bin/bash

# List available models from the NRP LLM endpoint
curl -H "Authorization: Bearer $MY_LLM_TOKEN" \
     -H "Content-Type: application/json" \
     https://ellm.nrp-nautilus.io/v1/models
