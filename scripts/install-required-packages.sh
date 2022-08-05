#!/bin/bash

export PRINT_PREFIX="KubePiHole Install Deps"

#
#
# A helper function to install the necessary packages (dependencies) on a fresh Raspberry Pi OS install
# Ref: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
# From: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management
#
#
function install_dependencies() {
    print_assistant "Ensuring your package repositories are up-to-date..."
    sudo apt-get update # needs to run as sudo on Raspberry Pi OS because there is no default root user...

    # print_assistant "Moving to \$HOME directory for installation ($HOME)..."
    # cd $HOME

    print_assistant "Installing the necessary packages for running a Kubernetes cluster..."

    print_assistant "1.1) Install pre-reqs for kubectl via apt-get..."
    # curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo apt-get install -y ca-certificates curl
    sudo apt-get install -y apt-transport-https

    # print_assistant "1.2) Validate the binary (optional but good)..."

    print_assistant "1.2) Pull the apt-key..."
    # curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

    print_assistant "1.3) Add the apt repository..."
    # echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check # TODO: add handler if the above command outputs FAILED
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

    print_assistant "1.3) Install kubectl"
    sudo apt-get update
    sudo apt-get install -y kubectl
    # chmod +x kubectl
    # mkdir -p ~/.local/bin
    # mv ./kubectl ~/.local/bin/kubectl
}
