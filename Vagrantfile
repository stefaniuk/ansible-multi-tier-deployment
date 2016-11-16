VAGRANTFILE_API_VERSION = "2"

box = "ubuntu/trusty64"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # Tier 1: Presentation

    t1_name = "web"
    (1..2).each do |i|
        config.vm.define t1_name + "#{i}" do |node|
            node.vm.box = box
            node.vm.hostname = t1_name +  "#{i}"
            node.vm.synced_folder ".", "/project"
            node.vm.network "private_network", ip: "192.168.200.1#{i}"
            node.vm.provider :virtualbox do |vb|
                vb.name = t1_name +  "#{i}"
                vb.cpus = 1
                vb.memory = 256
                vb.customize ["modifyvm", :id, "--cpuexecutioncap", "33"]
            end
        end
    end

    # Tier 2: Application

    t2_name = "app"
    (1..2).each do |i|
        config.vm.define t2_name + "#{i}" do |node|
            node.vm.box = box
            node.vm.hostname = t2_name +  "#{i}"
            node.vm.synced_folder ".", "/project"
            node.vm.network "private_network", ip: "192.168.200.2#{i}"
            node.vm.provider :virtualbox do |vb|
                vb.name = t2_name +  "#{i}"
                vb.cpus = 1
                vb.memory = 256
                vb.customize ["modifyvm", :id, "--cpuexecutioncap", "33"]
            end
        end
    end

    # Tier 3: Data (inside Docker host)

    config.vm.define "data" do |node|
        node.vm.box = box
        node.vm.hostname = "data"
        node.vm.synced_folder ".", "/project"
        node.vm.provision :docker
        node.vm.provision "shell", path: "provision/data.sh"
        node.vm.network "private_network", ip: "192.168.200.30"
        node.vm.provider :virtualbox do |vb|
            vb.name = "data"
            vb.cpus = 4
            vb.memory = 4096
            vb.customize ["modifyvm", :id, "--cpuexecutioncap", "66"]
        end
    end

    # Manager (Ansible)

    config.vm.define "manager" do |node|
        node.vm.box = box
        node.vm.hostname = "manager"
        node.vm.synced_folder ".", "/project"
        node.vm.provision "shell", path: "provision/manager.sh"
        node.vm.network "private_network", ip: "192.168.200.200"
        node.vm.provider :virtualbox do |vb|
            vb.name = "manager"
            vb.cpus = 1
            vb.memory = 128
            vb.customize ["modifyvm", :id, "--cpuexecutioncap", "20"]
        end
    end

end
