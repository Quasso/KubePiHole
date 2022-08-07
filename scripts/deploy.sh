#!/bin/bash

export PRINT_PREFIX="KubePiHole DEPLOY"
export PIHOLE_NAME="pihole-kube"

# The function that maps and deploys all the necessary k8s manifests!
function deploy_pihole() {
    export PIHOLE_PV_CAPACITY=2Gi
    export DNSMASQ_PV_CAPACITY=500Mi

    mkdir -p $PERSISTENCE_LOCAL;
    mkdir -p $PERSISTENCE_PIHOLE;
    mkdir -p $PERSISTENCE_ETC;
    mkdir -p $PERSISTENCE_DNSMASQ;

    local K8S_DEPLOY="$PWD/kube/templates/pihole-k8s_template.yaml"
    local K8S_DEPLOY_GEN="$PWD/kube/generated/pihole-k8s.yaml"
    local K8S_SVC="$PWD/kube/templates/pihole-k8s-svc_template.yaml"
    local K8S_SVC_GEN="$PWD/kube/generated/pihole-k8s-svc.yaml"

    envsubst_and_apply_manifest $K8S_DEPLOY $K8S_DEPLOY_GEN
    envsubst_and_apply_manifest $K8S_SVC $K8S_SVC_GEN
}
