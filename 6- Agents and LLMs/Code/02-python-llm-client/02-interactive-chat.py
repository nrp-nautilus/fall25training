#!/usr/bin/env python3

# Interactive chat script with the deepseek-r1 model
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

# Interactive chat function
def interactive_chat():
    print("Chat with deepseek-r1 model (type 'quit' to exit)")
    print("-" * 40)
    
    while True:
        user_input = input("\nYou: ")
        if user_input.lower() == 'quit':
            break
            
        data = {
            "model": "deepseek-r1",
            "messages": [{"role": "user", "content": user_input}],
            "max_tokens": 200,
            "temperature": 0.7
        }
        
        try:
            response = requests.post(url, headers=headers, json=data)
            result = response.json()
            
            if "choices" in result and len(result["choices"]) > 0:
                message = result["choices"][0]["message"]
                # DeepSeek-R1 returns content in reasoning_content field
                if "reasoning_content" in message and message["reasoning_content"]:
                    print(f"Assistant: {message['reasoning_content']}")
                elif "content" in message and message["content"]:
                    print(f"Assistant: {message['content']}")
                else:
                    print("Error: No content in response")
            else:
                print("Error: No response")
        except Exception as e:
            print(f"Error: {e}")

if __name__ == "__main__":
    interactive_chat()
