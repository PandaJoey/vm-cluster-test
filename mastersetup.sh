#!/bin/bash

echo "####################"
echo "installing microk8s"
echo "####################"
#install required files
sudo apt update -y && sudo upgrade -y
sudo snap install microk8s --classic --channel=1.18/stable
microk8s status --wait-ready
sudo usermod -a -G microk8s ubuntu
sudo chown -f -R ubuntu ~/.kube

echo "#########################"
echo "creating node join file 1"
echo "#########################"
# add nodes to get info needs to somehow get the users name probably need to get inout
sudo microk8s add-node | grep  "microk8s join" | grep -v "node with"| head -1 > /home/dev/nodejoinfiles/node1

echo "#########################"
echo "creating node join file 2"
echo "#########################"

sudo microk8s add-node | grep  "microk8s join" | grep -v "node with"| head -1 > /home/dev/nodejoinfiles/node2

# save files from vm to pc
exit
