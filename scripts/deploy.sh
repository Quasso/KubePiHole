#!/bin/bash

export PRINT_PREFIX="KubePiHole DEPLOY"

# Kubernetes template files
local K8S_STORAGECLASS="/kube/templates/kube-pihole-storageclass.yaml"
local K8S_PVCS="/kube/templates/kube-pihole-pvc.yaml"
local K8S_PVS="/kube/templates/kube-pihole-pv.yaml"

# The function that maps and deploys all the necessary k8s manifests!
function deploy_pihole() {
    print_assistant "Deploy Pi-hole function is now running!"
}