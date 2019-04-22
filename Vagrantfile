# -*- mode: ruby -*-
# vi: set ft=ruby :

$user="project"
$password="project"

$vm_name="docker-box"
$vm_ip="10.0.0.10"

Vagrant.configure("2") do |cfg|
    cfg.ssh.username = $user
    cfg.ssh.forward_x11 = true
    cfg.ssh.shell = "bash"

    cfg.vm.box = "nfqlt/docker"

    cfg.vm.network "private_network", ip: $vm_ip, netmask: "255.255.0.0"
    cfg.vm.provider "virtualbox" do |vbox|
        vbox.name = $vm_name
        vbox.customize ["modifyvm", :id, "--cpus", 4]
        vbox.customize ["modifyvm", :id, "--memory", "6144"]
        vbox.customize ["modifyvm", :id, "--name", $vm_name]
        vbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

        vbox.customize ["modifyvm", :id, "--nic1", "nat"]
        vbox.customize ["modifyvm", :id, "--nictype1", "virtio"]

        vbox.customize ["modifyvm", :id, "--nic2", "hostonly"]
        vbox.customize ["modifyvm", :id, "--nictype2", "virtio"]
        vbox.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"]

        vbox.customize ["setextradata", :id, "--VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
        vbox.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 500]
    end

    cfg.vm.provision "shell", inline: "/root/scripts/bootstrap.sh '"+$vm_name+"' '"+$vm_ip+"'"
    cfg.vm.provision "shell", inline: "/root/scripts/networking.sh", run: "always"
    cfg.vm.provision "shell", inline: "/vagrant/scripts/install-smb.sh"
end
