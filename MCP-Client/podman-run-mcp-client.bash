podman build --no-cache --rm -f Containerfile -t mcpclient:demo .
podman run --interactive --tty mcpclient:demo
