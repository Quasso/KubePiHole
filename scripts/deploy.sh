#!/bin/bash

export PRINT_PREFIX="KubePiHole DEPLOY"
export PIHOLE_NAME="pihole-kube"

# The function that maps and deploys all the necessary k8s manifests!
function deploy_pihole() {

    # Kubernetes template files
    # local K8S_STORAGECLASS="$PWD/kube/templates/kube-pihole-storageclass.yaml"
    # local K8S_STORAGECLASS_GEN="$PWD/kube/generated/kube-pihole-storageclass.yaml"

    # local K8S_PVCS="$PWD/kube/templates/kube-pihole-pvc.yaml"
    # local K8S_PVCS_GEN="$PWD/kube/generated/kube-pihole-pvc.yaml"

    # local K8S_PVS="$PWD/kube/templates/kube-pihole-pv.yaml"
    # local K8S_PVS_GEN="$PWD/kube/generated/kube-pihole-pv.yaml"

    export PIHOLE_PV_CAPACITY=2Gi
    export DNSMASQ_PV_CAPACITY=500Mi

    # print_assistant "Deploy Pi-hole function is now running!" "title"

    # envsubst_and_apply_manifest $K8S_STORAGECLASS $K8S_STORAGECLASS_GEN

    # sleep 3

    # envsubst_and_apply_manifest $K8S_PVCS $K8S_PVCS_GEN

    # sleep 3

    # envsubst_and_apply_manifest $K8S_PVS $K8S_PVS_GEN

    # sleep 3

    # print_assistant "Great success! All of the necessary storage definitions have completed."
    # sleep 3

    mkdir -p $PERSISTENCE_LOCAL;
    mkdir -p $PERSISTENCE_ETC;
    mkdir -p $PERSISTENCE_DNSMASQ;

    local K8S_DEPLOY="$PWD/kube/templates/pihole-k8s_template.yaml"
    local K8S_DEPLOY_GEN="$PWD/kube/generated/pihole-k8s.yaml"

    envsubst_and_apply_manifest $K8S_DEPLOY $K8S_DEPLOY_GEN
}
