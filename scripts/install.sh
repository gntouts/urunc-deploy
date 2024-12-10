#!/bin/bash

set -e

# Install urunc binary
curl -L -o /usr/local/bin/urunc \
    https://github.com/nubificus/urunc/releases/download/v0.4.0/urunc_$(dpkg --print-architecture)
chmod +x /usr/local/bin/urunc

# Install containerd-shim-v2-urunc
curl -L -o /usr/local/bin/containerd-shim-v2-urunc \
    https://github.com/nubificus/urunc/releases/download/v0.4.0/containerd-shim-urunc-v2_$(dpkg --print-architecture)
chmod +x /usr/local/bin/containerd-shim-v2-urunc

# Install hypervisors
apt-get update
apt-get install -y qemu-system-x86
# apt-get install -y qemu-system-x86 firecracker solo5-hvt

# Configure containerd for urunc
cat <<EOF > /etc/containerd/config.toml
[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.urunc]
  runtime_type = "io.containerd.urunc.v2"
EOF

# Restart containerd
systemctl restart containerd
