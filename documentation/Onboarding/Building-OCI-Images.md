
# Prerequisite
Building OCI images requires [podman](https://podman.io/getting-started/installation) installed.

- [WSL2 - Install Podman](https://devcoops.com/install-podman-on-ubuntu-20-04/)

# Build

Build command: ``podman build --no-cache -t <image-name>:latest --build-arg PATkey=<pat-key> .``

Note: ``PATkey`` is a personal access token of package repository.

# Run

Run command: ``podman run -p <local-port>:<host-port> <image-name>``





