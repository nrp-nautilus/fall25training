#!/bin/bash

# Run all tests to demonstrate the LLM endpoints
echo "=== NRP LLM Endpoints Test Suite ==="
echo "Using token: ${MY_LLM_TOKEN:0:10}..."

echo -e "\n1. Listing available models:"
./list-models.sh | jq '.data[] | {id: .id, name: .name}' 2>/dev/null || ./list-models.sh

echo -e "\n2. Testing chat completion:"
./chat-completion.sh "Tell me a short joke about programming"

echo -e "\n3. Testing different models:"
./chat-completion.sh "What is machine learning?" "qwen3"

echo -e "\n4. Testing endpoints availability:"
./test-endpoints.sh

echo -e "\n=== Tests completed ==="
