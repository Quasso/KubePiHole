#!/bin/bash

function space_terminal() {
    echo ""
    echo "===================================="
    echo ""
}

function print_assistant() {
    MESSAGE=$1
    STYLE=$2

    if [[ -z $STYLE ]]; then
        # style not set, output default
        echo ""
        echo "[$PRINT_PREFIX] $MESSAGE"
        echo ""
    else
        if [[ $STYLE == "title" ]]; then
            space_terminal
            echo "$MESSAGE"
            space_terminal
        fi
    fi
}
