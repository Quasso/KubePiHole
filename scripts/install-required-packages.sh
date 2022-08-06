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
    print_assistant "Installing the necessary packages for running a Kubernetes cluster..."

    print_assistant "1) Install pre-reqs for kubectl via apt-get..."
    sudo apt-get install -y ca-certificates curl
    sudo apt-get install -y apt-transport-https

    print_assistant "1.2) Pull the apt-key..."
    sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

    print_assistant "1.3) Add the apt repository..."
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

    print_assistant "2) Install kubectl"
    sudo apt-get update
    sudo apt-get install -y kubectl
}
