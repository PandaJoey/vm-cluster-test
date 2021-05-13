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



#echo "####################"
#echo "getting address of the server."
#echo "####################"
#sudo IFNAME=$1
#sudo ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
#sudo sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

# remove ubuntu-bionic entry
#sudo sed -e '/^.*ubuntu-focal64.*/d' -i /etc/hosts
#sudo sed -i -e 's/#DNS=/DNS=8.8.8.8/' /etc/systemd/resolved.conf


echo "####################"
echo "updating hosts"
echo "####################"
# Update /etc/hosts about other hosts
sudo cat >> /etc/hosts <<EOF
192.168.33.13 master
192.168.33.14 worker-1
192.168.33.15 worker-2
EOF

#echo "####################"
#echo "restarting the resolved host."
#echo "####################"
#service systemd-resolved restart

echo "#########################"
echo "creating node join file 1"
echo "#########################"
# add nodes to get info needs to somehow get the users name probably need to get inout
#sudo microk8s add-node | grep  "microk8s join" | grep -v "node with"| head -1 > /home/node1
sudo microk8s add-node > /home/node1
echo "#########################"
echo "creating node join file 2"
echo "#########################"

#sudo microk8s add-node | grep  "microk8s join" | grep -v "node with"| head -1 > /home/node2
sudo microk8s add-node > /home/node2
# save files from vm to pc
exit
