podman build --no-cache --rm -f Containerfile -t mcpserver:demo .
podman run --interactive --tty -p 3000:3000 mcpserver:demo
echo "browse http://localhost:3000/up"
