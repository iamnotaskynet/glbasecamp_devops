#!/bin/bash
. show.sh
. funcs.sh

function check_arg() {
    # echo "checking \"$1\"";
    if [[ "$1" == "--help" || "$1" == "help" ]]; then show_help; exit 1;
    elif [[ $1 == "--version" || $1 == "version" ]]; then show_version; exit 1;
    elif [[ $1 = *[[:space:]]* ]]; then show_error "Spaces not allowed!" \; exit 128;
    elif [[ ! $1 =~ ^[-+]?[0-9]+\.?[0-9]*[-|+|/|\*]{1}[0-9]+\.?[0-9]*$ ]]; then
        # then show_error "Condition is not valid";
        echo "128";
    else 
        echo "0";
    fi;
};