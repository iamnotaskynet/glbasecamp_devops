while true; 
do 
    ( 
    echo -ne "HTTP/1.1 200 OK\r\nContent-Length: $(wc -c <index.html)\r\n\r\n" ; 
    cat index.html; 
    ) | nc -l -p 8000 ; 
done
