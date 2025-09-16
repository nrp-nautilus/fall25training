#!/usr/bin/env python3

# Test different models with the same prompt (using deepseek-r1 and glm-v)
import os
import requests
import json

# Get token from environment variable
token = os.getenv("MY_LLM_TOKEN")
if not token:
    print("Error: MY_LLM_TOKEN not set")
    exit(1)

# Configuration
url = "https://ellm.nrp-nautilus.io/v1/chat/completions"
headers = {
    "Authorization": f"Bearer {token}",
    "Content-Type": "application/json"
}

# Test different models
models = ["deepseek-r1", "glm-v"]
prompt = "Write a haiku about programming"

print(f"Testing prompt: '{prompt}'")
print("=" * 50)

for model in models:
    print(f"\n--- {model} ---")
    
    data = {
        "model": model,
        "messages": [{"role": "user", "content": prompt}],
        "max_tokens": 100,
        "temperature": 0.7
    }
    
    try:
        response = requests.post(url, headers=headers, json=data)
        result = response.json()
        
        if "choices" in result and len(result["choices"]) > 0:
            message = result["choices"][0]["message"]
            # DeepSeek-R1 returns content in reasoning_content field
            if "reasoning_content" in message and message["reasoning_content"]:
                print(message["reasoning_content"])
            elif "content" in message and message["content"]:
                print(message["content"])
            else:
                print("Error: No content in response")
        else:
            print("Error: No response")
    except Exception as e:
        print(f"Error: {e}")
