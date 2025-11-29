podman run --detach --gpus=all -v ollama:/root/.ollama --publish 11434:11434 --env OLLAMA_API_KEY=secret-key --name docker.io/ollama ollama/ollama
podman exec -it ollama ollama pull qwen3:8b
