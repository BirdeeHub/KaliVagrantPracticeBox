# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
# 
$aptupgrade = <<-SCRIPT
echo
echo Running apt upgrade...
#echo OMG it takes so long...
apt upgrade -y
SCRIPT
$fix_home_folder_ownership = <<-SCRIPT
chown vagrant:vagrant -R /home/vagrant/*
SCRIPT
$autoclean = <<-SCRIPT
echo
echo Running apt autoclean...
apt autoclean
SCRIPT
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "kalilinux/rolling"
  #set name in vagrant
  config.vm.define "birdeeKali"
  #run the above provisioning scripts
  config.vm.provision "shell", path: ".Provisioning\\vagrantfile_scripts\\new_ssh_key_script.sh"
  config.vm.provision "shell", path: ".Provisioning\\vagrantfile_scripts\\always_run_script.sh", run: "always"
  config.vm.provision "shell", path: ".Provisioning\\vagrantfile_scripts\\main_provision_script.sh"
  config.vm.provision "shell", inline: $aptupgrade #running upgrade before github pulls can help with  
  #install scripts that check dependency version. But it takes a long time so i separated it for easy comment-out.
  config.vm.provision "shell", path: ".Provisioning\\vagrantfile_scripts\\github_script.sh"
  config.vm.provision "shell", inline: $fix_home_folder_ownership
  config.vm.provision "shell", path: ".Provisioning\\vagrantfile_scripts\\alias_script.sh"
  config.vm.provision "shell", path: ".Provisioning\\vagrantfile_scripts\\testing_script.sh"
  config.vm.provision "shell", inline: $autoclean #separated out to easily make sure it runs last when adding more stuff.

  #define new port to prevent host collision with other vagrant vms
  config.ssh.guest_port = "2202"
  config.vm.network "forwarded_port", guest: 22, host: 2202, host_ip: "127.0.0.1", id: "ssh"
  config.vm.provider 'virtualbox' do |v|
    v.gui = false
    #set RAM
    v.memory = "4096"

    #set name
    v.name = "birdeeKali"
    # SSH - now dealt with above, and the rest below. ssh rule here preserved for reference.
    #v.customize ["modifyvm", :id, "--nat-pf1", "delete", "ssh"]
    #v.customize ["modifyvm", :id, "--nat-pf1", "SSH,tcp,127.0.0.1,2202,,22"]
  end
  #config.vm.network "forwarded_port", guest: 80, host: 10000, host_ip: "127.0.0.1", name: "DVWA"
  #config.vm.network "forwarded_port", guest: 3000, host: 3000, host_ip: "127.0.0.1", name: "beef1"
  #config.vm.network "forwarded_port", guest: 6789, host: 6789, host_ip: "127.0.0.1", name: "beef2"
  #config.vm.network "forwarded_port", guest: 61985, host: 61985, host_ip: "127.0.0.1", name: "beef3"
  #config.vm.network "forwarded_port", guest: 61986, host: 61986, host_ip: "127.0.0.1", name: "beef4"
  #config.vm.network "forwarded_port", guest: 80, host: 10001, host_ip: "127.0.0.1", name: "hackazon"
  #config.vm.network "forwarded_port", guest: 80, host: 10003, host_ip: "127.0.0.1", name: "webgoatwolf1"
  #config.vm.network "forwarded_port", guest: 80, host: 10004, host_ip: "127.0.0.1", name: "webgoatwolf2"
  #config.vm.network "forwarded_port", guest: 80, host: 10005, host_ip: "127.0.0.1", name: "juiceshop"
  #config.vm.network "forwarded_port", guest: 80, host: 10006, host_ip: "127.0.0.1", name: "bricks"
  #config.vm.network "forwarded_port", guest: 80, host: 10011, host_ip: "127.0.0.1", name: "bwapp"
  #config.vm.network "forwarded_port", guest: 80, host: 10012, host_ip: "127.0.0.1", name: "bodgeit"
  #config.vm.network "forwarded_port", guest: 80, host: 10013, host_ip: "127.0.0.1", name: "webgoat-dn"
  #config.vm.network "forwarded_port", guest: 80, host: 1000, host_ip: "127.0.0.1", name: "Mutillidae1"
  #config.vm.network "forwarded_port", guest: 80, host: 20002, host_ip: "127.0.0.1", name: "Mutillidae2"
  #config.vm.network "forwarded_port", guest: 80, host: 10007, host_ip: "127.0.0.1", name: "shellshock11and21"
  #config.vm.network "forwarded_port", guest: 80, host: 20007, host_ip: "127.0.0.1", name: "shellshock12"
  #config.vm.network "forwarded_port", guest: 80, host: 10009, host_ip: "127.0.0.1", name: "heartbleed"
end
