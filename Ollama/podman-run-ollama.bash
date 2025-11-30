#!/bin/bash

# Check if a container named 'ollama' already exists
if podman container exists ollama; then
    echo "Container 'ollama' exists. Starting it..."
    podman start ollama
else
    echo "Container 'ollama' not found. Creating and starting a new one..."
    podman run --detach --gpus=all -v ollama:/root/.ollama --publish 11434:11434 --env OLLAMA_API_KEY=secret-key --name ollama docker.io/ollama/ollama
    podman exec -it ollama ollama pull qwen3:8b
fi

# Follow the logs of the 'ollama' container
podman logs --follow ollama
