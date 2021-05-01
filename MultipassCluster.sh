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

git clone https://github.com/PandaJoey/vm-cluster-test/blob/master/CheckWorking.sh
git clone https://github.com/PandaJoey/vm-cluster-test/blob/master/MultipassCluster.sh
git clone https://github.com/PandaJoey/vm-cluster-test/blob/master/cleanup.sh
git clone https://github.com/PandaJoey/vm-cluster-test/blob/master/mastersetup.sh
git clone https://github.com/PandaJoey/vm-cluster-test/blob/master/vmcluster.yaml
git clone https://github.com/PandaJoey/vm-cluster-test/blob/master/worker1setup.sh
git cline https://github.com/PandaJoey/vm-cluster-test/blob/master/worker2setup.sh




## everything from here needs to be in yaml
echo "###################"
echo "entering master vm"
echo "###################"
# enter shell for vm 1
multipass shell master


#cd ~/nodejoinfiles/
#curl curlip



