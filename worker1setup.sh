#!/bin/bash

echo "####################"
echo "installing microk8s"
echo "####################"
#install required files
sudo apt update -y 
sudo apt upgrade -y
sudo snap install microk8s --classic --channel=1.18/stable
microk8s status --wait-ready
sudo usermod -a -G microk8s ubuntu
sudo chown -f -R ubuntu ~/.kube


IFNAME=$1
ADDRESS="$(ip -4 addr show $IFNAME | grep "inet" | head -1 |awk '{print $2}' | cut -d/ -f1)"
sed -e "s/^.*${HOSTNAME}.*/${ADDRESS} ${HOSTNAME} ${HOSTNAME}.local/" -i /etc/hosts

# remove ubuntu-bionic entry
sed -e '/^.*ubuntu-focal64.*/d' -i /etc/hosts
sed -i -e 's/#DNS=/DNS=8.8.8.8/' /etc/systemd/resolved.conf

# Update /etc/hosts about other hosts
cat >> /etc/hosts <<EOF
192.168.33.13 master
192.168.33.14 worker-1
192.168.33.15 worker-2
EOF


echo "####################"
echo "running join command"
echo "####################"
#get first join file to join cluster
# somehow make it wait to join the cluster before exiting.
sudo chmod +x /vagrant/node1
#could also exit and renter here to not have to sudo
cd /vagrant/

sudo ./node1

exit
