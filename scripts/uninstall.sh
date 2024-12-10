#!/bin/bash

# Remove binaries
rm -f /usr/local/bin/urunc
rm -f /usr/local/bin/containerd-shim-v2-urunc

# Uninstall hypervisors
# apt-get remove -y qemu-system-x86 firecracker solo5-hvt
apt-get remove -y qemu-system-x86

# Clean containerd configuration
sed -i '/urunc/d' /etc/containerd/config.toml

# Restart containerd
systemctl restart containerd