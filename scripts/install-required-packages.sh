#!/bin/sh

# A helper function to install the necessary packages (dependencies) on a fresh Raspberry Pi OS install

function install_dependencies() {
    echo "Ensuring your package repositories are up-to-date..."
    apt-get update # may need to run as sudo...

    echo "Installing the necessary packages for running a Kubernetes cluster..."

    echo "1.1) Install kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

    echo "1.2) Validate the binary (optional but good)..."
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
    # TODO: add handler if the above command outputs FAILED
}