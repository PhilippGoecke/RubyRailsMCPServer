podman run --detach --gpus=all -v ollama:/root/.ollama --publish 11434:11434 --env OLLAMA_API_KEY=secret-key --name ollama docker.io/ollama/ollama
podman exec -it ollama ollama pull qwen3:8b
#podman run --detach ollama
podman logs --follow ollama
