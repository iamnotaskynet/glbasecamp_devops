#!/bin/bash

function calc_add(){ echo "$(($1 + $2))"; }
function calc_sub(){ echo "$(($1 - $2))"; }
function calc_mult(){ echo "$(($1 * $2))"; }
function calc_divi(){ 
    echo "$(($1 / $2))"; 
}

function calc() {
    local input_data=$1;
    local result="";
    local tokens=();
    local num1="";
    local num2="";
    local scale1=0;
    local scale2=0;
    local operation="";
    
    if   [[ $input_data == *'+'* ]]; then operation="+";
    elif [[ $input_data == *'-'* ]]; then operation="-";
    elif [[ $input_data == *'*'* ]]; then operation="*";
    elif [[ $input_data == *'/'* ]]; then operation="/";
    else show_error "Can't proceed $1"; exit 128;
    fi;
    # Tokenizing input
    tmp_op=$operation
    if [[ $operation == "*" || $operation == "/" ]]; then tmp_op="\\$operation"; fi;
    tokens=(${input_data//$tmp_op/ });

   # Tokenizing first number

    if [[ ${tokens[0]} == *'.'* ]]; then 
        num1s=(${tokens[0]//./ });
        scale1=${#num1s[1]};
        num1="${num1s[0]}${num1s[1]}";
    else num1=${tokens[0]};
    fi;

   # Tokenizing seconf number

    if [[ ${tokens[1]} == *'.'* ]]; then 
        num2s=(${tokens[1]//./ });
        scale2=${#num2s[1]};
        num2="${num2s[0]}${num2s[1]}";
    else num2=${tokens[0]};
    fi;

    # Preparing vars for result formula in printf() calculating
    local multiplyer=1;
    local scale=1;
    local difference=1;

    if      [[ $scale1 -eq $scale2 ]]; then 
        scale=$scale1;
    elif    [[ $scale1 -gt $scale2 ]]; then 
        difference=$(($scale1-$scale2));
        echo "diff $difference";
        num2=$(($num2*10*$difference));
        scale=$scale1;
    elif    [[ $scale1 -lt $scale2 ]]; then 
        difference=$(($scale2-$scale1));
        num1=$(($num1*10*$difference));
        scale=$scale2;
    fi;

    # calculating MULTIPLYER for + and -
    if [[ $operation == "+" || $operation == "-" ]]; then
        for ((i = 1 ; i <= $scale ; i++)); do multiplyer=$((multiplyer*10)); done;
        result=$(printf %.$scale\f "$((10**3 * ($num1$operation$num2)/$multiplyer ))e-3");
    fi;
    # calculating MULTIPLYER for *
    if [[ $operation == "*" ]]; then
        multiplyer=10;
        for ((i = 1 ; i <= $scale+$difference ; i++)); do multiplyer=$((multiplyer*10)); done;
        result=$(printf %.$scale\f "$((10**3 * ($num1$operation$num2)/$multiplyer ))e-3");
    fi;
    # calculating  SCALING NUMS for /
    if [[ $operation == "/" ]]; then
        scale=$(($scale1*$scale2*$scale));
        result=$(printf %.$scale\f "$((10**3 * $num1$operation$num2 ))e-3");
    fi;
  
    show_result $result;

};