while true; 
do
    clear;
    kubectl get po -lapp | lolcat;
    sleep 4;
done 
