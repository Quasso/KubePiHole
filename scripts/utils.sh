#!/bin/bash

space_terminal() {
    echo ""
    echo "===================================="
    echo ""
}

print_assistant() {
    MESSAGE=$1
    STYLE=$2

    echo ""
    echo "[$PRINT_PREFIX] $MESSAGE"
    echo ""
}
