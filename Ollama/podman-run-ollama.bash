#!/bin/bash

# Check if a container named 'ollama' already exists
if podman container exists ollama; then
    echo "Container 'ollama' exists. Starting it..."
    podman start ollama
else
    echo "Container 'ollama' not found. Creating and starting a new one..."
    # CPU only
    #podman run --detach --volume ollama:/root/.ollama --publish 11434:11434 --name ollama docker.io/ollama/ollama
    # GPU enabled
    # apt install nvidia-container-toolkit && nvidia-ctk runtime configure --runtime=podman && systemctl restart podman
    podman run --detach --gpus=all --volume ollama:/root/.ollama --publish 11434:11434 --env OLLAMA_API_KEY=secret-key --name ollama docker.io/ollama/ollama
    # AMD ROCm enabled
    #podman run --detach --device /dev/kfd --device /dev/dri --volume ollama:/root/.ollama --publish 11434:11434 --name ollama docker.io/ollama/ollama:rocm
    # AMD ROCm enabled with Vulkan
    #podman run --detach --device /dev/kfd --device /dev/dri --volume ollama:/root/.ollama --publish 11434:11434 --env OLLAMA_VULKAN=1 --name ollama docker.io/ollama/ollama
fi

# Wait for the container to be in the 'running' state
echo "Waiting for the container to start..."
while [[ "$(podman inspect -f '{{.State.Status}}' ollama)" != "running" ]]; do
    sleep 1
done
echo "Container is running."
podman exec -it ollama ollama pull qwen3:8b

# Follow the logs of the 'ollama' container
podman logs --follow ollama
