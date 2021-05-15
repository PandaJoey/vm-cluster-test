#!/bin/bash

echo "####################"
echo "installing microk8s"
echo "####################"
#install required files
sudo apt update -y
sudo apt upgrade -y
sudo snap install microk8s --classic --channel=1.18/stable
sudo microk8s status --wait-ready
sudo usermod -a -G microk8s ubuntu
sudo chown -f -R ubuntu ~/.kube

echo "####################"
echo "updating hosts"
echo "####################"
# Update /etc/hosts about other hosts
sudo cat >> /etc/hosts <<EOF
192.168.33.13 master
192.168.33.14 worker-1
192.168.33.15 worker-2
EOF

echo "#########################"
echo "creating node join file 1"
echo "#########################"
# add nodes to get info needs to somehow get the users name probably need to get inout
#sudo microk8s add-node | grep  "microk8s join" | grep -v "node with"| head -1 > /home/node1
sudo microk8s add-node | grep "192." > /home/node1
echo "#########################"
echo "creating node join file 2"
echo "#########################"
#sudo microk8s add-node | grep  "microk8s join" | grep -v "node with"| head -1 > /home/node2
sudo microk8s add-node | grep "192." > /home/node2
# save files from vm to pc

echo "##################################################"
echo "setting up kubernetes cluster and management"
echo "##################################################"
sudo source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
sudo echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.
sudo alias k=kubectl
sudo complete -F __start_kubectl k

echo "##################################################"
echo "running kubectl apply"
echo "##################################################"
sudo microk8s kubectl apply -f  https://raw.githubusercontent.com/PandaJoey/vm-cluster-test/master/vmcluster.yaml

exit
