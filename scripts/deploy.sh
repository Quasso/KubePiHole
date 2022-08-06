#!/bin/bash

export PRINT_PREFIX="KubePiHole DEPLOY"

# The function that maps and deploys all the necessary k8s manifests!
function deploy_pihole() {
    export PIHOLE_NAME="kube-pihole"
    # Kubernetes template files
    local K8S_STORAGECLASS="$HOME/KubePiHole/kube/templates/kube-pihole-storageclass.yaml"
    local K8S_PVCS="$HOME/KubePiHole/kube/templates/kube-pihole-pvc.yaml"
    local K8S_PVS="$HOME/KubePiHole/kube/templates/kube-pihole-pv.yaml"

    print_assistant "Deploy Pi-hole function is now running!" "title"

    # sudo k3s kubectl

    envsubst_and_apply_manifest $K8S_STORAGECLASS

    envsubst_and_apply_manifest $K8S_PVCS

    envsubst_and_apply_manifest $K8S_PVS
}
