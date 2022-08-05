#!/bin/bash

export PRINT_PREFIX="KubePiHole Install Deps"

# A helper function to install the necessary packages (dependencies) on a fresh Raspberry Pi OS install

function install_dependencies() {
    print_assistant "Ensuring your package repositories are up-to-date..."
    sudo apt-get update # needs to run as sudo on Raspberry Pi OS because there is no default root user...
    
    print_assistant "Moving to \$HOME directory for installation ($HOME)..."
    cd $HOME

    print_assistant "Installing the necessary packages for running a Kubernetes cluster..."

    print_assistant "1.1) Download kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

    print_assistant "1.2) Validate the binary (optional but good)..."

    print_assistant "1.2.1) Pull the sha256..."
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

    print_assistant "1.2.2) Verify the sha256..."
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check # TODO: add handler if the above command outputs FAILED

    print_assistant "1.3) Install kubectl"
    chmod +x kubectl
    mkdir -p ~/.local/bin
    mv ./kubectl ~/.local/bin/kubectl
}
