#!/bin/bash

export PRINT_PREFIX="KubePiHole DEPLOY"

# The function that maps and deploys all the necessary k8s manifests!
function deploy_pihole() {
    PIHOLE_NAME="kube-pihole"
    # Kubernetes template files
    local K8S_STORAGECLASS="./kube/templates/kube-pihole-storageclass.yaml"
    local K8S_PVCS="./kube/templates/kube-pihole-pvc.yaml"
    local K8S_PVS="./kube/templates/kube-pihole-pv.yaml"

    print_assistant "Deploy Pi-hole function is now running!" "title"

    envsubst_and_apply_manifest $K8S_STORAGECLASS

    envsubst_and_apply_manifest $K8S_PVCS

    envsubst_and_apply_manifest $K8S_PVS
}
