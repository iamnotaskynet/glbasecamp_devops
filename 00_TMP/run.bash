#!/bin/bash

# TODO: with xdotool
# xdotool type --delay 500 "ls -a"
# xdotool key Return

# lecture_commands.bash example

mapfile -t commands < example.bash;
length=${#commands[@]};

current_command="string with spaces";
function emulate_typing() {
    # echo PS1
    user=$(whoami);
    pwd=$(pwd);
    prompt="$(whoami)@$(pwd)";
    printf "\e[40;0;31m${prompt}\e[40;0;37m"
    sleep 0.7
    for (( i=0 ; i < ${#current_command} ; i++ ));
    do
        printf "${current_command:i:1}";
        sleep 0.3
    done
    sleep 0.5
    echo ""
};
# emulate_typing

for (( j=0; j<$length; j++ )); 
do 
    current_command=${commands[$j]};
    emulate_typing;
    eval ${commands[$j]};
done






# echo commands

# while IFS= read -r line; 
# do xdotool type --delay 500 "$line" && xdotool key Return ;
# done < example