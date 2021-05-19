Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/focal64"
    config.vm.define "master", primary: true do |master|
        master.vm.hostname = "master"
        master.vm.network "private_network", ip: "192.168.33.13"
        master.vm.disk :disk, size: "2GB", name: "shareddrive"
        master.vm.synced_folder "/home/dev/vagrantcluster/", "/home"
        master.vm.provider "virtualbox" do |virtualbox|
            virtualbox.memory = "4096"
            virtualbox.cpus = 4
            virtualbox.name = "master"
        end
            master.vm.provision "setup-hosts", :type => "shell", :path => "https://raw.githubusercontent.com/PandaJoey/vm-cluster-test/master/mastersetup.sh" do |s|
        end
    end

    config.vm.box = "ubuntu/focal64"
    config.vm.define  "worker-1" do |worker1|
        worker1.vm.hostname = "worker-1"
        worker1.vm.network "private_network", ip: "192.168.33.14"
        worker1.vm.disk :disk, size: "2GB", name: "shareddrive"
        worker1.vm.synced_folder "/home/dev/vagrantcluster/", "/home"
        worker1.vm.provider "virtualbox" do |virtualbox|
            virtualbox.memory = "2048"
            virtualbox.cpus = 2
            virtualbox.name = "worker-1"
        end
            worker1.vm.provision "setup-hosts", :type => "shell", :path => "https://raw.githubusercontent.com/PandaJoey/vm-cluster-test/master/worker1setup.sh" do |s|
        end
    end

    config.vm.box = "ubuntu/focal64"
    config.vm.define  "worker-2" do |worker2|
        worker2.vm.hostname = "worker-2"
        worker2.vm.network "private_network", ip: "192.168.33.15"
        worker2.vm.disk :disk, size: "2GB", name: "shareddrive"
        worker2.vm.synced_folder "/home/dev/vagrantcluster/", "/home"
        worker2.vm.provider "virtualbox" do |virtualbox|
            virtualbox.memory = "2048"
            virtualbox.cpus = 2
            virtualbox.name = "worker-2"
        end
           worker2.vm.provision "setup-hosts", :type => "shell", :path => "https://raw.githubusercontent.com/PandaJoey/vm-cluster-test/master/worker1setup.sh" do |s|
        end
     end

end