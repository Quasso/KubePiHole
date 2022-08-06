#!/bin/bash

export PRINT_PREFIX="KubePiHole Install Deps"

function finalise_config() {
    mkdir -p ./kube/generated
    DEFAULT_K3S_KUBECONF=/etc/rancher/k3s/k3s.yaml
    CUSTOM_KUBECONF=./kube/generated/k3s-custom.yaml
    print_assistant "Time to copy the default config into here so it can be modified to allow kubectl to run..."
    sudo cp $DEFAULT_K3S_KUBECONF $CUSTOM_KUBECONF
}

#
#
# A helper function to install the necessary packages (dependencies) on a fresh Raspberry Pi OS install
# Ref: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
# From: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management
#
#
function install_dependencies() {
    PI_IS_ANCIENT=true

    print_assistant "Installing the necessary packages for running a Kubernetes cluster..."

    if [[ $PI_IS_ANCIENT == true ]]; then
        K3S_EXISTS=$(sudo k3s --version | grep version)
        print_assistant "Pi is ancient!!"

        if [[ $K3S_EXISTS == "" ]]; then
            print_assistant "1) Install k3s..."
            print_assistant "After a while, this will finish... be patient!"
            curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v0.9.1 sh - # for older Pis
            print_assistant "k3s has installed now..."
        else
            # anything special?
            echo "placeholder for else statement"
        fi
        finalise_config
    else
        curl -sfL https://get.k3s.io | sh - # armv7 ONLY!
    fi

    # print_assistant "2) Reconfigure to fix the connectivity of k3s kubectl..."
    # sudo k3s kubectl config set-cluster server=https://127.0.0.1:6444
    # sudo k3s kubectl config view
    # systemctl stop k3s

    # print_assistant "3) Run k3s server with custom config..."
    # sudo k3s server \
    #     --bind-address "127.0.0.1" \
    #     --http-listen-port 8080 \
    #     --https-listen-port 6443 \
    #     --write-kubeconfig-mode false
}
