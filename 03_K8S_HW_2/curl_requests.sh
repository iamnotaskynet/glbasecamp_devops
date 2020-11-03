# Colors
BOLD='\e[1m'
GREEN='\e[92m' 
CYAN='\e[36m'
MAGENTA='\e[35m'
NC='\e[0m' 

BG_DARKGRAY='\e[100m'
BG_DEFAULT='\e[49m'

while true; 
do 
    # echo -e "${}${}"
    echo -e "${BOLD}${GREEN}$(date)${NC}";

    echo "From 192.168.0.210:";
    echo -e "${GREEN}${BG_DARKGRAY}";
    curl 192.168.0.210;
    echo -e "${NC}${BG_DEFAULT}";

    echo "From 192.168.0.212:";
    echo -e "${GREEN}${BG_DARKGRAY}"
    curl 192.168.0.212;
    echo -e "${NC}${BG_DEFAULT}";
    
    sleep 4; 
done