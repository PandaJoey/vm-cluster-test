#!/bin/bash
#
# commands required before entering vms

echo "###############"
echo "script starting"
echo "###############"



echo "############"
echo "snap install"
echo "############"
sudo snap install multipass

echo "#####################"
echo "making script sleept"
echo "#####################"
sleep 30s
#create vms
echo "#############"
echo "creating vm's"
echo "#############"

multipass launch -m 3Gb -n master
multipass launch -m 3Gb -n worker-1
multipass launch -m 3Gb -n worker-2



echo "######################"
echo "making file dir"
echo "######################"
mkdir nodejoinfiles
echo "######################"
echo "creating mount points"
echo "######################"

multipass mount ~/nodejoinfiles master
multipass mount ~/nodejoinfiles worker-1
multipass mount ~/nodejoinfiles worker-2

## everything from here needs to be in yaml
echo "###################"
echo "entering master vm"
echo "###################"
# enter shell for vm 1
multipass shell master

## ok we need to make files with this date in to copy to the vm to continue from here :()

echo "####################"
echo "installing microk8s"
echo "####################"
#install required files
sudo snap install microk8s --classic --channel=1.18/stable
microk8s status --wait-ready
sudo usermod -a -G microk8s ubuntu
sudo chown -f -R ubuntu ~/.kube

echo "#########################"
echo "creating node join file 1"
echo "#########################"
# add nodes to get info needs to somehow get the users name probably need to get inout
sudo microk8s add-node | grep  "microk8s join" | grep -v "node with"| head -1 > ~/nodejoinfiles/node1

echo "#########################"
echo "creating node join file 2"
echo "#########################"

sudo microk8s add-node | grep  "microk8s join" | grep -v "node with"| head -1 > ~/nodejoinfiles/node2

# save files from vm to pc
exit

echo "#########################"
echo "entering vm 2"
echo "#########################"
# enter shell for vm 2
multipass shell worker-1

echo "####################"
echo "installing microk8s"
echo "####################"
#install required files
sudo snap install microk8s --classic --channel=1.18/stable
microk8s status --wait-ready
sudo usermod -a -G microk8s ubuntu
sudo chown -f -R ubuntu ~/.kube

echo "####################"
echo "running join command"
echo "####################"
#get first join file to join cluster
# somehow make it wait to join the cluster before exiting.
sudo chmod +x /home/dev/nodejoinfiles/node1
#could also exit and renter here to not have to sudo
cd /home/dev/nodejoinfiles/

sudo ./node1

exit

echo "####################"
echo "entering vm 3"
echo "####################"
# enter shell for vm 3
multipass shell worker-2

echo "####################"
echo "installing microk8s"
echo "####################"
#install required files
sudo snap install microk8s --classic --channel=1.18/stable
microk8s status --wait-ready
sudo usermod -a -G microk8s ubuntu
sudo chown -f -R ubuntu ~/.kube

echo "####################"
echo "running join command"
echo "####################"
#get first join file to join cluster
# somehow make it wait to join the cluster before exiting.
sudo chmod +x /home/dev/nodejoinfiles/node2
cd /home/dev/nodejoinfiles/
sudo ./node2

exit

echo "####################"
echo "entering master vm"
echo "####################"
#renter vm1 to set up the cluster
multipass shell master

echo "####################"
echo "installing app scaling and exposing ports"
echo "####################"
#deploy the cluster.
microk8s kubectl create deployment microbot --image=dontrebootme/microbot:v1 #make sure this waits some time.
microk8s kubectl scale deployment microbot --replicas=3
microk8s kubectl expose deployment microbot --type=NodePort --port=80 --name=microbot-service



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

echo "####################"
echo "unmounting drives."
echo "####################"
multipass unmount ~/nodejoinfiles master
multipass unmount ~/nodejoinfiles worker-1
multipass unmount ~/nodejoinfiles worker-2

#cd ~/nodejoinfiles/
#curl curlip



