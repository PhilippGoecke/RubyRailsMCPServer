podman build --no-cache --rm --file Containerfile --tag pythonmcpserver:demo .
podman run --interactive --tty --publish 3000:3000 pythonmcpserver:demo
echo "browse http://localhost:3000/health"
