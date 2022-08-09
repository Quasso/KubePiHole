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
    DEST=$2

    print_assistant "Substituting env vars for manifest $TEMPLATE & applying..."
    cat $TEMPLATE | envsubst >$DEST
    if [[ -z $KUBE_DESKTOP || $KUBE_DESKTOP == false ]]; then
        sudo kubectl -n $KUBE_NS apply -f $DEST
    elif [[ $KUBE_DESKTOP == true ]]; then
        kubectl -n $KUBE_NS apply -f $DEST
    fi
}
