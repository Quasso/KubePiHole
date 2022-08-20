#!/bin/bash

export PRINT_PREFIX="KubePiHole DEPLOY"
export PIHOLE_NAME="pihole-kube"
export PIHOLE_HOSTNAME="${PIHOLE_NAME}-localhost"

# The function that maps and deploys all the necessary k8s manifests!
function deploy_pihole() {
    export PIHOLE_PV_CAPACITY=2Gi
    export DNSMASQ_PV_CAPACITY=500Mi

    mkdir -p $PERSISTENCE_LOCAL
    mkdir -p $PERSISTENCE_PIHOLE
    mkdir -p $PERSISTENCE_ETC
    mkdir -p $PERSISTENCE_DNSMASQ

    local K8S_DEPLOY="$PWD/kube/templates/pihole-k8s_template.yaml"
    local K8S_DEPLOY_GEN="$PWD/kube/generated/pihole-k8s.yaml"
    local K8S_SVC="$PWD/kube/templates/pihole-k8s-svc_template.yaml"
    local K8S_SVC_GEN="$PWD/kube/generated/pihole-k8s-svc.yaml"

    envsubst_and_apply_manifest $K8S_DEPLOY $K8S_DEPLOY_GEN
    envsubst_and_apply_manifest $K8S_SVC $K8S_SVC_GEN

    space_terminal_lg
    echo "Congratulations, here are some useful outputs regarding the resources created..."
    echo

    echo "Services generated:"
    echo
    kubectl get svc -n pihole
    echo

    echo "Pods generated:"
    echo
    kubectl get pod -n pihole
    echo

    space_terminal_lg
    echo "Great success! You can now access the web console on http://localhost:8000/admin"
    echo "Your temporary password is:"
    echo "${PIHOLE_WEB_PASSWORD}"
    echo
    echo "Change it immediately. Happy blocking!"

    echo
    echo "Sleeping for 5 seconds before trying port-bind..."
    sleep 5

    space_terminal_lg
    echo "Forwarding the port so you can access the web UI locally..."
    kubectl port-forward service/pihole-ui-svc 8000:80
}
