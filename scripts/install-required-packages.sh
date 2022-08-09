#!/bin/bash

export PRINT_PREFIX="KubePiHole Install Deps"

function finalise_config() {
    mkdir -p ./kube/generated
    DEFAULT_K3S_KUBECONF=/etc/rancher/k3s/k3s.yaml
    CUSTOM_KUBECONF=./kube/generated/k3s-custom.yaml
    print_assistant "Time to copy the default config into here so it can be modified to allow kubectl to run..."
    sudo cp $DEFAULT_K3S_KUBECONF $CUSTOM_KUBECONF
    echo "YOU MUST CHANGE THE VALUE of 6443 to 6444 to work on this version! (5s pause)"
    sleep 5
    echo "For convenience, here's the file. Edit the port and save with ctrl + x! (3s pause)"
    sleep 3
    sudo nano $CUSTOM_KUBECONF
}

#
#
# A helper function to install the necessary packages (dependencies) on a fresh Raspberry Pi OS install
# Ref: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
# From: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management
#
#
function install_dependencies() {
    PI_IS_ANCIENT=false

    print_assistant "Installing the necessary packages for running a Kubernetes cluster..."

    if [[ $PI_IS_ANCIENT == true && -z $KUBE_DESKTOP ]]; then
        K3S_EXISTS=$(sudo k3s --version | grep version)
        print_assistant "Pi is ancient!!"

        if [[ $K3S_EXISTS == "" ]]; then
            print_assistant "1) Install k3s..."
            print_assistant "After a while, this will finish... be patient!"
            curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v0.9.1 sh - # for older Pis
            print_assistant "k3s has installed now..."
        else
            echo "Already installed! Nice, k3s is installed already on this system, great!"
        fi
        # don't run this on Pis, k3s uses the port 6443
        # finalise_config
    elif [[ $KUBE_DESKTOP == true ]]; then
        finalise_config
    else
        curl -sfL https://get.k3s.io | sh - # armv7 ONLY!
        # don't run this on Pis, k3s uses the port 6443
        # finalise_config
    fi
}
