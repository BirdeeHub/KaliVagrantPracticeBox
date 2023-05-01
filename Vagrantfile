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
$main_provision_script = <<-SCRIPT
echo
echo Running Provisioning Script...
apt update
apt install -y kali-linux-large
apt install tree wget snapd steghide foremost binwalk remmina python3-pip cupp gobuster awscli tldr openjdk-11-jre maven -y;
apt install nuclei --fix-missing

echo
echo Installing go
wget -O go.tar.gz https://go.dev/dl/go1.20.3.linux-amd64.tar.gz
tar -C /usr/local/ -xzf go.tar.gz
rm go.tar.gz
echo "export GOPATH=/root/go-workspace" >> /home/vagrant/.zshrc
echo "export GOROOT=/usr/local/go" >> /home/vagrant/.zshrc
echo "PATH=$PATH:$GOROOT/bin/:$GOPATH/bin" >> /home/vagrant/.zshrc

#echo
#echo Installing Zap... nevermind its in kali-linux-large
#echo 'deb http://download.opensuse.org/repositories/home:/cabelo/Debian_Testing/ /' | sudo tee /etc/apt/sources.list.d/home:cabelo.list
#curl -fsSL https://download.opensuse.org/repositories/home:cabelo/Debian_Testing/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_cabelo.gpg > /dev/null
#sudo apt update
#sudo apt install owasp-zap

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
echo Copying Scripts from .Provisioning...
cp /vagrant/.Provisioning/ssh/sshTHM.sh /home/vagrant/
chmod 775 /home/vagrant/sshTHM.sh
tar xzvvf /vagrant/.Provisioning/tools_misc.tar.gz -C /home/vagrant/
gunzip /usr/share/wordlists/rockyou.txt.gz
cp /usr/share/wordlists/rockyou.txt /home/vagrant/
cp /vagrant/.Provisioning/intrigue_docker.sh /home/vagrant/
cp /vagrant/.Provisioning/copy_firefox.sh /home/vagrant/

SCRIPT
$aptupgrade = <<-SCRIPT
echo
echo Running apt upgrade...
#omg it takes so long
apt upgrade -y
SCRIPT
$github_script = <<-SCRIPT
#echo
#echo Installing GithubCLI... not that necessary...
#curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
#&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
#&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
#&& sudo apt update \
#&& sudo apt install gh -y

echo
echo Cloning Various GitHub Repositories...
[ ! -d "/home/vagrant/git_repos" ] && mkdir /home/vagrant/git_repos
git clone https://github.com/int0x33/nc.exe.git /home/vagrant/git_repos/nc.exe
git clone https://github.com/fortra/impacket.git /home/vagrant/git_repos/impacket
git clone https://github.com/carlospolop/PEASS-ng.git /home/vagrant/git_repos/PEASS-ng
git clone https://github.com/BlackArch/webshells.git /home/vagrant/git_repos/webshells
git clone https://github.com/danielmiessler/Source2URL.git /home/vagrant/git_repos/Source2URL
git clone https://github.com/0xDexter0us/Scavenger.git /home/vagrant/git_repos/Scavenger
git clone https://github.com/michael1026/trashcompactor.git /home/vagrant/git_repos/trashcompactor
git clone https://github.com/xnl-h4ck3r/waymore.git /home/vagrant/git_repos/waymore
git clone https://github.com/xnl-h4ck3r/xnLinkFinder.git /home/vagrant/git_repos/xnLinkFinder
git clone https://github.com/xnl-h4ck3r/GAP-Burp-Extension.git /home/vagrant/git_repos/GAP-Burp-Extension
git clone https://github.com/xnl-h4ck3r/urless.git /home/vagrant/git_repos/urless
git clone https://github.com/xnl-h4ck3r/HandE-Burp-Extension.git /home/vagrant/git_repos/HandE-Burp-Extension
git clone https://github.com/xnl-h4ck3r/knoxnl.git /home/vagrant/git_repos/knoxnl
git clone https://github.com/dwisiswant0/apkleaks.git /home/vagrant/git_repos/apkleaks
git clone https://github.com/dgtlmoon/changedetection.io.git /home/vagrant/git_repos/changedetection.io
git clone https://github.com/jaeles-project/gospider.git /home/vagrant/git_repos/gospider
git clone https://github.com/LewisArdern/metasecjs.git /home/vagrant/git_repos/metasecjs
git clone https://github.com/1ndianl33t/Gf-Patterns.git /home/vagrant/git_repos/Gf-Patterns
git clone https://github.com/projectdiscovery/subfinder.git /home/vagrant/git_repos/subfinder
git clone https://github.com/vysecurity/DomLink.git /home/vagrant/git_repos/DomLink
git clone https://github.com/assetnote/commonspeak2.git /home/vagrant/git_repos/commonspeak2
git clone https://github.com/assetnote/commonspeak2-wordlists.git /home/vagrant/git_repos/commonspeak2-wordlists
git clone https://github.com/assetnote/kiterunner.git /home/vagrant/git_repos/kiterunner
git clone https://github.com/projectdiscovery/alterx.git /home/vagrant/git_repos/alterx
git clone https://github.com/FortyNorthSecurity/EyeWitness.git /home/vagrant/git_repos/EyeWitness
git clone https://github.com/clr2of8/GatherContacts.git /home/vagrant/git_repos/GatherContacts
git clone https://github.com/tomnomnom/waybackurls.git /home/vagrant/git_repos/waybackurls
git clone https://github.com/daudmalik06/ReconCat.git /home/vagrant/git_repos/ReconCat
git clone https://github.com/maurosoria/dirsearch.git /home/vagrant/git_repos/dirsearch
git clone https://github.com/danielmiessler/RobotsDisallowed.git /home/vagrant/git_repos/RobotsDisallowed
git clone https://github.com/appsecco/bugcrowd-levelup-subdomain-enumeration.git /home/vagrant/git_repos/bugcrowd-levelup-subdomain-enumeration
git clone https://github.com/We5ter/Scanners-Box.git /home/vagrant/git_repos/Scanners-Box
git clone https://github.com/dionach/CMSmap.git /home/vagrant/git_repos/CMSmap
git clone https://github.com/puzzlepeaches/Log4jUnifi /home/vagrant/git_repos/Log4jUnifi
git clone https://github.com/veracode-research/rogue-jndi /home/vagrant/git_repos/rogue-jndi \
&& mvn package -f /home/vagrant/git_repos/rogue-jndi

# if you need other linpeas and dont want to compile you can edit this command
wget -O /home/vagrant/git_repos/PEASS-ng/winPEASx64.exe https://github.com/carlospolop/PEASS-ng/releases/download/refs%2Fpull%2F260%2Fmerge/winPEASx64.exe

chown vagrant:vagrant -R /home/vagrant/*
SCRIPT
$alias_script = <<-SCRIPT
echo
echo Adding Aliases to .zshrc file...
echo "alias gobuckets='gobuster vhost -w ~/git_repos/SecLists/Discovery/DNS/subdomains-top1million-5000.txt --append-domain -u '" >> /home/vagrant/.zshrc

SCRIPT
$testing_script = <<-SCRIPT
sudo apt update
git clone https://github.com/1N3/Sn1per.git /home/vagrant/git_repos/Sn1per
/home/vagrant/git_repos/Sn1per/install.sh force #IT STILL PROMPTS AAAHHHHHH
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
  config.vm.provision "shell", inline: $new_ssh_key_script
  config.vm.provision "shell", inline: $always_run_script, run: "always"
  config.vm.provision "shell", inline: $main_provision_script
  config.vm.provision "shell", inline: $aptupgrade #running upgrade before github pulls can help with install scripts that check dependency version. but it takes a long time so i separated it for easy comment-out.
  config.vm.provision "shell", inline: $github_script
  config.vm.provision "shell", inline: $alias_script
  config.vm.provision "shell", inline: $testing_script
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
