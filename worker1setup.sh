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

echo "##################################################"
echo "setting up kubernetes cluster and management"
echo "##################################################"
source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.
alias k=kubectl
complete -F __start_kubectl k

echo "#######################"
echo "editing hosts files"
echo "#######################"
# Update /etc/hosts about other hosts
sudo cat >> /etc/hosts <<EOF
192.168.33.13 master
192.168.33.14 worker-1
192.168.33.15 worker-2
EOF

echo "####################"
echo "running join command"
echo "####################"
if [ $HOSTNAME == "worker-1" ]
then
    sudo chmod +x /vagrant/node1
    cd /vagrant/
    sudo ./node1
else
    sudo chmod +x /vagrant/node2
    cd /vagrant/
    sudo ./node2

exit
