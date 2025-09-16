#!/bin/bash

# Test different API endpoints to see what's available
echo "Testing /v1/models endpoint:"
curl -s -H "Authorization: Bearer $MY_LLM_TOKEN" https://ellm.nrp-nautilus.io/v1/models | head -5

echo -e "\n\nTesting /v1/chat/completions endpoint:"
curl -s -X POST \
     -H "Authorization: Bearer $MY_LLM_TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"model": "glm-v", "messages": [{"role": "user", "content": "Hello"}], "max_tokens": 50}' \
     https://ellm.nrp-nautilus.io/v1/chat/completions

echo -e "\n\nTesting /v1/embeddings endpoint:"
curl -s -X POST \
     -H "Authorization: Bearer $MY_LLM_TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"model": "embed-mistral", "input": "test text"}' \
     https://ellm.nrp-nautilus.io/v1/embeddings
