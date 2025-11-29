podman run --detach --gpus=all --volumes ollama:/root/.ollama --publish 11434:11434 --name ollama ollama/ollama
docker exec -it ollama ollama pull qwen3:8b
