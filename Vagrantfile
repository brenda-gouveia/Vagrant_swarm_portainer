# -*- mode: ruby -*-
# vi: set ft=ruby  :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "davekpatrick/ubuntu-2204"
  config.vm.box_version = "2022.1.4"

  NODES = {
    "master" => { ip: "192.168.56.10", cpus: 1, memory: 1024 },
    "worker1" => { ip: "192.168.56.11", cpus: 1, memory: 512 },
    "worker2" => { ip: "192.168.56.12", cpus: 1, memory: 512 }
  }

  NODES.each do |name, opts|
    config.vm.define name do |node|
      node.vm.hostname = name
      node.vm.network :private_network, ip: opts[:ip]

      node.vm.provider "virtualbox" do |vb|
        vb.memory = opts[:memory]
        vb.cpus = opts[:cpus]
        vb.customize ["modifyvm", :id, "--uartmode1", "disconnected"]
      end

      node.vm.provision "shell", path: "scripts/install_docker.sh"
    end
  end

  config.vm.define "master" do |master|
    master.vm.provision "shell", path: "scripts/init_swarm.sh", privileged: true
  end

  ["worker1", "worker2"].each do |worker|
    config.vm.define worker do |node|
      node.vm.provision "shell", path: "scripts/join_worker.sh", privileged: true
    end
  end
end