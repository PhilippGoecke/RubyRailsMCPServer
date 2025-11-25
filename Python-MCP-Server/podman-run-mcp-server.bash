podman build --no-cache --rm -f Containerfile -t pythonmcpserver:demo .
podman run --interactive --tty -p 3000:3000 pythonmcpserver:demo
echo "browse http://localhost:3000/health"
