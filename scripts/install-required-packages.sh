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
}
