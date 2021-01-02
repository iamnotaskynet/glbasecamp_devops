#!/bin/bash
. funcs.sh
. show.sh
. check_arg.sh

#strict mode
if   [[  -z $1 ]];          then show_error "Please specify condition";     exit 128;
elif [[  -n $1 && -n $2 ]]; then show_error "Only one argument allowed";    exit 128;
elif [[  -n $1 && -z $2 ]]; then 
    #Check the incoming parameter
    result_check=$(check_arg $1);
    show_debug "$result_check";
    if [[ "$result_check" != "0" ]]; then 
        show_error "Arguments NOT ok!";
        exit 128;
    elif [[ "$result_check" == "0" ]]; then
        show_debug "Arguments is ok!";
        calc $1;
    fi;

fi;
