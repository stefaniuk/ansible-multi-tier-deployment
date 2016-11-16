VAGRANTFILE_API_VERSION = "2"

box = "centos/7"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # Router (NGINX)

    config.vm.define "router" do |node|
        node.vm.box = "ubuntu/trusty64"
        node.vm.hostname = "router"
        node.vm.provision "shell", path: "provision/nginx.sh"
        node.vm.network "private_network", ip: "192.168.200.2"
        node.vm.provider :virtualbox do |vb|
            vb.name = "router"
            vb.cpus = 1
            vb.memory = 128
            vb.customize ["modifyvm", :id, "--cpuexecutioncap", "20"]
        end
    end

    # Tier 1: Presentation

    tier1 = "web"
    (1..2).each do |i|
        config.vm.define tier1 + "#{i}" do |node|
            node.vm.box = box
            node.vm.hostname = tier1 +  "#{i}"
            node.vm.network "private_network", ip: "192.168.200.1#{i}"
            node.vm.provider :virtualbox do |vb|
                vb.name = tier1 +  "#{i}"
                vb.cpus = 1
                vb.memory = 256
                vb.customize ["modifyvm", :id, "--cpuexecutioncap", "33"]
            end
        end
    end

    # Tier 2: Application

    tier2 = "app"
    (1..2).each do |i|
        config.vm.define tier2 + "#{i}" do |node|
            node.vm.box = box
            node.vm.hostname = tier2 +  "#{i}"
            node.vm.network "private_network", ip: "192.168.200.2#{i}"
            node.vm.provider :virtualbox do |vb|
                vb.name = tier2 +  "#{i}"
                vb.cpus = 1
                vb.memory = 256
                vb.customize ["modifyvm", :id, "--cpuexecutioncap", "33"]
            end
        end
    end

    # Tier 3: Data (Docker host)

    config.vm.define "docker" do |node|
        node.vm.box = "ubuntu/trusty64"
        node.vm.hostname = "docker"
        node.vm.provision "shell", path: "provision/docker.sh"
        node.vm.network "private_network", ip: "192.168.200.30"
        node.vm.provider :virtualbox do |vb|
            vb.name = "docker"
            vb.cpus = 2
            vb.memory = 2048
            vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
        end
    end

    # Manager (Ansible)

    config.vm.define "manager" do |node|
        node.vm.box = "ubuntu/trusty64"
        node.vm.hostname = "manager"
        node.vm.synced_folder "./scripts", "/scripts"
        node.vm.provision "shell", path: "provision/ansible.sh"
        node.vm.network "private_network", ip: "192.168.200.200"
        node.vm.provider :virtualbox do |vb|
            vb.name = "manager"
            vb.cpus = 1
            vb.memory = 128
            vb.customize ["modifyvm", :id, "--cpuexecutioncap", "20"]
        end
    end

end
