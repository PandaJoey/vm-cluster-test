#!/bin/bash
#
# commands required before entering vms

echo "###############"
echo "script starting"
echo "###############"



echo "############"
echo "snap install"
echo "############"
cd ~/

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

cd ~/nodejoinfiles

git clone https://github.com/PandaJoey/vm-cluster-test.git

## everything from here needs to be in yaml
echo "###################"
echo "entering master vm"
echo "###################"
# enter shell for vm 1
multipass shell master


#cd ~/nodejoinfiles/
#curl curlip



