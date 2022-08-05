#!/bin/bash

print_assistant() {
    PREFIX=$1
    MESSAGE=$2
    STYLE=$3

    echo ""
    echo "[$PREFIX] $MESSAGE"
    echo ""
}