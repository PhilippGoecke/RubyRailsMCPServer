podman build --no-cache --rm --file Containerfile --tag mcpserver:demo .
podman run --interactive --tty --publish 3000:3000 mcpserver:demo
echo "browse http://localhost:3000/mcp"
