#!/bin/bash

function space_terminal_lg() {
    echo
    echo
    echo "=============================================="
    echo
    echo
}

function space_terminal() {
    echo
    echo "===================================="
    echo
}

function print_assistant() {
    MESSAGE=$1
    STYLE=$2
    SUB_MESSAGE=$3

    if [[ -z $STYLE ]]; then
        # style not set, output default
        echo
        echo "[$PRINT_PREFIX] $MESSAGE"
        echo
    else
        if [[ $STYLE == "title" ]]; then
            space_terminal_lg
            echo "$MESSAGE" # echo "${COLOUR_GREEN}$MESSAGE${COLOUR_NC}"
            echo "--"
            echo $SUB_MESSAGE
            space_terminal_lg
        fi
    fi
}

function envsubst_and_apply_manifest() {
    TEMPLATE=$1

    print_assistant "Substituting env vars for manifest $TEMPLATE & applying..."
    cat $TEMPLATE | envsubst | sudo k3s kubectl -n kube-pihole --kubeconfig $HOME/KubePiHole/kube/generated/k3s-custom.yaml apply -f -
}