#!/usr/bin/env bash

echo "####################"
echo "checking it worked"
echo "####################"
#check the cluster installed correctly 
microk8s kubectl get all --all-namespaces

echo "####################"
echo "showing join ip"
echo "####################"
#get the ip address to connect too
ip a | grep -Eo "[0-9][0-9]"".""[0-9][0-9][0-9]"".""[0-9][0-9][0-9]"".""[0-9][0-9][0-9]"| head -1 > /home/dev/nodejoinfiles/curlip
exit
