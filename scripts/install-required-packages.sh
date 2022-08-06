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

    print_assistant "1) Install k3s..."
    curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v0.9.1 sh - # for older Pis
    # curl -sfL https://get.k3s.io | bash - # armv7 ONLY!
    # curl -Ls "https://sbom.k8s.io/$(curl -Ls https://dl.k8s.io/release/latest.txt)/release" | awk '/PackageName: k8s.gcr.io\// {print $2}'

    # print_assistant "2) Install pre-reqs for kubectl via apt-get..."
    # sudo apt-get install -y ca-certificates curl
    # sudo apt-get install -y apt-transport-https

    # print_assistant "3.1) Pull the apt-key..."
    # sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

    # print_assistant "3.2) Add the apt repository..."
    # echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

    # print_assistant "3.3) Install kubectl"
    # sudo apt-get update
    # sudo apt-get install -y kubectl
}
