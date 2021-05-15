#!/bin/bash

echo "####################"
echo "installing microk8s"
echo "####################"
#install required files
sudo apt update -y
sudo apt upgrade -y
sudo snap install microk8s --classic --channel=1.18/stable
sudo microk8s status --wait-ready
sudo usermod -a -G microk8s vagrant
sudo chown -f -R vagrant ~/.kube

echo "##################################################"
echo "setting up kubernetes cluster and management"
echo "##################################################"
#sudo source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
#sudo echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.
#sudo alias k=kubectl
#sudo complete -F __start_kubectl k

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
#!bin/bash

if [ "$HOSTNAME" = "worker-1" ]
then
    echo "worker-1"
    sudo chmod +x /vagrant/node1
    cd /vagrant/ || exit
    sudo ./node1
else
    echo "worker-2"
    sudo chmod +x /vagrant/node2
    cd /vagrant/  || exit
    sudo ./node2
fi
exit
