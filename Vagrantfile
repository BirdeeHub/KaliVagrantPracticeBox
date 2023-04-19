# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
# 

$new_ssh_key_script = <<-SCRIPT
echo
echo Creating SSH Keys...
runuser -l vagrant -c 'ssh-keygen -f /home/vagrant/.ssh/id_rsa -t rsa -N ""'
chmod 600 /home/vagrant/.ssh/id_rsa
chmod 644 /home/vagrant/.ssh/id_rsa.pub

SCRIPT

$always_run_script = <<-SCRIPT
echo
echo Saving Adapter Addresses...
/sbin/ifconfig | grep -F -e 'flags=' -e 'inet ' -e 'inet6 ' -e 'ether '| awk '{ print $1 " " $2 }' | sed s/inet6/""/ | sed s/inet/""/ | sed s/ether/""/ | sed s/flags=.*/""/ > /vagrant/adapter_addresses.txt

echo
echo Copying OVPN Files...
[ ! -d "/home/vagrant/OVPN" ] && mkdir /home/vagrant/OVPN
cp /vagrant/.Provisioning/OVPN/*/* /home/vagrant/OVPN/
chown vagrant:vagrant /home/vagrant/OVPN /home/vagrant/OVPN/*
chmod 770 /home/vagrant/OVPN
chmod 640 /home/vagrant/OVPN/*

echo
echo Adding Host key to authorized_keys if not already added...
key_found=0
while read -r line; do
  if [ "$line" = "$(cat /vagrant/.Provisioning/ssh/id_rsa.pub)" ]; then
    ((key_found++))
  fi
done <<< "$(cat /home/vagrant/.ssh/authorized_keys | grep $(cat /vagrant/.Provisioning/ssh/id_rsa.pub | awk '{ print $3 }'))"

if [[ $key_found == 0 ]]
then
    cat /vagrant/.Provisioning/ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
    chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
    chmod 600 /home/vagrant/.ssh/authorized_keys
fi
SCRIPT

$script = <<-SCRIPT
echo
echo Running Provisioning Script...
apt update
apt install tree wget snapd steghide foremost binwalk remmina python3-pip cupp gobuster awscli tldr -y;

echo
echo Installing docker...
apt install docker.io -y
systemctl enable docker --now
printf '%s\n' "deb https://download.docker.com/linux/debian bullseye stable" | sudo tee /etc/apt/sources.list.d/docker-ce.list
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-ce-archive-keyring.gpg
apt install -y docker-ce docker-ce-cli containerd.io
apt install podman -y
apt install docker-compose -y
cp /vagrant/docker-compose.yml /home/vagrant
sudo usermod -aG docker vagrant

echo
echo Installing the stuff that interferes with docker because pip3 runs as root...
pip3 install stegoveritas
stegoveritas_install_deps

echo
echo Installing bitwarden...
wget -O /home/vagrant/bitwarden.zip 'https://vault.bitwarden.com/download/?app=cli&platform=linux'
unzip /home/vagrant/bitwarden.zip
mv /home/vagrant/bw /home/vagrant/bitwarden
mv /home/vagrant/bitwarden /usr/bin
rm /home/vagrant/bitwarden.zip
chmod 775 /usr/bin/bitwarden
wget -O /home/vagrant/bitwardenGUI.AppImage 'https://vault.bitwarden.com/download/?app=desktop&platform=linux'
mv /home/vagrant/bitwardenGUI.AppImage /usr/bin/
cp /vagrant/.Provisioning/bitwarden/bitwarden.desktop /usr/share/applications/
cp /vagrant/.Provisioning/bitwarden/bitwardenGUI /usr/bin/
chmod 775 /usr/bin/bitwardenGUI
chmod 775 /usr/bin/bitwardenGUI.AppImage

echo
echo Copying Misc Scripts...
cp /vagrant/.Provisioning/ssh/sshTHM.sh /home/vagrant/
chown vagrant:vagrant /home/vagrant/sshTHM.sh
chmod 775 /home/vagrant/sshTHM.sh
tar xzvvf /vagrant/.Provisioning/tools_misc.tar.gz -C /home/vagrant/
gunzip /usr/share/wordlists/rockyou.txt.gz
cp /usr/share/wordlists/rockyou.txt /home/vagrant/

echo
echo Running apt upgrade...
apt upgrade -y

echo
echo Running apt autoclean...
apt autoclean
SCRIPT
$github_script = <<-SCRIPT
#echo
#echo Installing GithubCLI...
#curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
#&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
#&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
#&& sudo apt update \
#&& sudo apt install gh -y

echo
echo Cloning Various GitHub Repositories...
git clone https://github.com/danielmiessler/SecLists.git /home/vagrant/SecLists.git
git clone https://github.com/int0x33/nc.exe.git /home/vagrant/nc.exe.git
git clone https://github.com/fortra/impacket.git /home/vagrant/impacket.git
git clone https://github.com/carlospolop/PEASS-ng.git /home/vagrant/PEASS-ng.git
git clone https://github.com/BlackArch/webshells.git /home/vagrant/webshells.git

# if you need other linpeas and dont want to compile you can edit this command
wget -O /home/vagrant/PEASS-ng.git/winPEASx64.exe https://github.com/carlospolop/PEASS-ng/releases/download/refs%2Fpull%2F260%2Fmerge/winPEASx64.exe

SCRIPT
$alias_script = <<-SCRIPT
echo
echo Adding Aliases to .zshrc file...
echo "alias gobuckets='gobuster vhost -w ~/SecLists/Discovery/DNS/subdomains-top1million-5000.txt --append-domain -u '" >> /home/vagrant/.zshrc
echo
echo running source on .zshrc file...
source /home/vagrant/.zshrc
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
  config.vm.provision "shell", inline: $new_ssh_key_script
  config.vm.provision "shell", inline: $always_run_script, run: "always"
  config.vm.provision "shell", inline: $script
  config.vm.provision "shell", inline: $github_script
  config.vm.provision "shell", inline: $alias_script
  #define new port to prevent host collision with other vagrant vms
  config.ssh.guest_port = "2202"
  config.vm.provider 'virtualbox' do |v|
    v.gui = false
    #set RAM
    v.memory = "4096"

    #set name
    v.name = "birdeeKali"
# SSH
    v.customize ["modifyvm", :id, "--nat-pf1", "delete", "ssh"]
    v.customize ["modifyvm", :id, "--nat-pf1", "SSH,tcp,127.0.0.1,2202,,22"]
# DVWA
    v.customize ["modifyvm", :id, "--nat-pf1", "DVWA,tcp,127.0.0.1,10000,,10000"]
# beef
    v.customize ["modifyvm", :id, "--nat-pf1", "beef1,tcp,127.0.0.1,3000,,3000"]
    v.customize ["modifyvm", :id, "--nat-pf1", "beef2,tcp,127.0.0.1,6789,,6789"]
    v.customize ["modifyvm", :id, "--nat-pf1", "beef3,tcp,127.0.0.1,61985,,61985"]
    v.customize ["modifyvm", :id, "--nat-pf1", "beef4,tcp,127.0.0.1,61986,,61986"]

# Mutillidae
    #v.customize ["modifyvm", :id, "--nat-pf1", "Mutillidae1,tcp,127.0.0.1,1000,,1000"]
    #v.customize ["modifyvm", :id, "--nat-pf1", "Mutillidae2,tcp,127.0.0.1,20002,,20002"]

# bwapp:
    #v.customize ["modifyvm", :id, "--nat-pf1", "bwapp,tcp,127.0.0.1,10011,,10011"]

# shellshock
# image: cyberxsecurity/shellshock:latest
    #v.customize ["modifyvm", :id, "--nat-pf1", "shellshock11and21,tcp,127.0.0.1,10007,,10007"]
    #v.customize ["modifyvm", :id, "--nat-pf1", "shellshock12,tcp,127.0.0.1,20007,,20007"]

# bricks
    #v.customize ["modifyvm", :id, "--nat-pf1", "bricks,tcp,127.0.0.1,10006,,10006"]

# webgoatwolf
    #v.customize ["modifyvm", :id, "--nat-pf1", "webgoatwolf1,tcp,127.0.0.1,10003,,10003"]
    #v.customize ["modifyvm", :id, "--nat-pf1", "webgoatwolf2,tcp,127.0.0.1,10004,,10004"]

# hackazon
    #v.customize ["modifyvm", :id, "--nat-pf1", "hackazon,tcp,127.0.0.1,10001,,10001"]

# heartbleed
    #v.customize ["modifyvm", :id, "--nat-pf1", "heartbleed,tcp,127.0.0.1,10009,,10009"]

# shellshock
# image: hmlio/vaas-cve-2014-6271
    #has same port forward rule as the 1st rule of 1st shellshock vm
    #v.customize ["modifyvm", :id, "--nat-pf1", "shellshock21,tcp,127.0.0.1,10007,,10007"]

# webgoat-dn:
    #v.customize ["modifyvm", :id, "--nat-pf1", "webgoat-dn,tcp,127.0.0.1,10013,,10013"]

# bodgeit:
    #v.customize ["modifyvm", :id, "--nat-pf1", "bodgeit,tcp,127.0.0.1,10012,,10012"]

# juiceshop:
    #v.customize ["modifyvm", :id, "--nat-pf1", "juiceshop,tcp,127.0.0.1,10005,,10005"]
  end
end
