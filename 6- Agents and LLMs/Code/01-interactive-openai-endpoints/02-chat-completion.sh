#!/bin/bash

# Send a chat completion request to the LLM
# Usage: ./chat-completion.sh "Your message here"

MESSAGE="$1"
MODEL="${2:-glm-v}"

curl -X POST \
     -H "Authorization: Bearer $MY_LLM_TOKEN" \
     -H "Content-Type: application/json" \
     -d "{
       \"model\": \"$MODEL\",
       \"messages\": [
         {
           \"role\": \"user\",
           \"content\": \"$MESSAGE\"
         }
       ],
       \"max_tokens\": 200,
       \"temperature\": 0.7
     }" \
     https://ellm.nrp-nautilus.io/v1/chat/completions
