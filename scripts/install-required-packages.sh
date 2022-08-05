#!/bin/bash

source utils.sh

# A helper function to install the necessary packages (dependencies) on a fresh Raspberry Pi OS install

function install_dependencies() {
    print_assistant "Ensuring your package repositories are up-to-date..."
    sudo apt-get update # needs to run as sudo on Raspberry Pi OS because there is no default root user...

    print_assistant "Installing the necessary packages for running a Kubernetes cluster..."

    print_assistant "1.1) Install kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

    print_assistant "1.2) Validate the binary (optional but good)..."
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    print_assistant "$(cat kubectl.sha256)  kubectl" | sha256sum --check
    # TODO: add handler if the above command outputs FAILED
}
