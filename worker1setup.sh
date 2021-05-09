#!/bin/bash

echo "####################"
echo "installing microk8s"
echo "####################"
#install required files
sudo apt update -y && sudo apt upgrade -y
sudo snap install microk8s --classic --channel=1.18/stable
microk8s status --wait-ready
sudo usermod -a -G microk8s ubuntu
sudo chown -f -R ubuntu ~/.kube

echo "####################"
echo "running join command"
echo "####################"
#get first join file to join cluster
# somehow make it wait to join the cluster before exiting.
sudo chmod +x /home/dev/dockerstuff/OwnScripts/vagrantcluster/node1
#could also exit and renter here to not have to sudo
cd /home/dev/dockerstuff/OwnScripts/vagrantcluster

sudo ./node1

exit
