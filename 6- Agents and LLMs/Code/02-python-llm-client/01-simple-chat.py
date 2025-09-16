#!/usr/bin/env python3

# Simple Python script to chat with the deepseek-r1 model
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

# Chat with deepseek-r1 model
def chat(message):
    data = {
        "model": "deepseek-r1",
        "messages": [{"role": "user", "content": message}],
        "max_tokens": 150,
        "temperature": 0.7
    }
    
    try:
        response = requests.post(url, headers=headers, json=data, timeout=30)
        response.raise_for_status()
        result = response.json()
        
        if "choices" in result and len(result["choices"]) > 0:
            message = result["choices"][0]["message"]
            # DeepSeek-R1 returns content in reasoning_content field
            if "reasoning_content" in message and message["reasoning_content"]:
                return message["reasoning_content"]
            elif "content" in message and message["content"]:
                return message["content"]
        return "Error: No choices in response"
    except requests.exceptions.Timeout:
        return "Error: Request timed out"
    except requests.exceptions.RequestException as e:
        return f"Error: {e}"

# Test the chat
print("Chatting with deepseek-r1 model...")
response = chat("Hello! Can you explain what machine learning is in simple terms?")
print(f"Response: {response}")
