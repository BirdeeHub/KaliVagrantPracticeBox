#!/bin/bash
echo
echo Running Provisioning Script...
apt update
apt install -y kali-linux-large
apt install tree wget snapd steghide foremost binwalk remmina python3-pip cupp gobuster awscli tldr openjdk-11-jre maven -y;
apt install nuclei --fix-missing
apt install -y novnc tigervnc* kali-desktop-i3 xfce4-terminal

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
[ ! -d "/home/vagrant/dockercompose" ] && mkdir /home/vagrant/dockercompose
cp -r /vagrant/dockercompose/* /home/vagrant/dockercompose
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
[ ! -d "/home/vagrant/misc_copy" ] && mkdir /home/vagrant/misc_copy
tar xzvvf /vagrant/.Provisioning/misc_copy/tools_misc.tar.gz -C /home/vagrant/
gunzip /usr/share/wordlists/rockyou.txt.gz
cp /usr/share/wordlists/rockyou.txt /home/vagrant/misc_copy/
cp /vagrant/.Provisioning/misc_copy/intrigue_docker.sh /home/vagrant/misc_copy/
cp /vagrant/.Provisioning/misc_copy/copy_firefox.sh /home/vagrant/misc_copy/
echo Installing Minesweeper...
/vagrant/.Provisioning/misc_copy/installdebianpackage.sh

wget -O /home/vagrant/misc_copy/deepce.sh https://github.com/stealthcopter/deepce/raw/main/deepce.sh
wget -O /home/vagrant/misc_copy/cdk https://github.com/cdk-team/CDK/releases/download/v1.5.2/cdk_darwin_amd64
wget -O /home/vagrant/misc_copy/winPEASx64.exe https://github.com/carlospolop/PEASS-ng/releases/download/refs%2Fpull%2F260%2Fmerge/winPEASx64.exe

[ ! -d "/home/vagrant/vnc" ] && mkdir /home/vagrant/vnc
cp -r /vagrant/.Provisioning/vnc/* /home/vagrant/vnc/
#cp /vagrant/.Provisioning/vnc/startnovnc.sh /home/vagrant/vnc
#cp /vagrant/.Provisioning/vnc/startnoi3.sh /home/vagrant/vnc
#cp /vagrant/.Provisioning/vnc/BurpFox.sh /home/vagrant/vnc
#cp /vagrant/.Provisioning/vnc/BurpSuiteVNC.sh /home/vagrant/vnc
#cp /vagrant/.Provisioning/vnc/FireFoxVNC.sh /home/vagrant/vnc

[ ! -d "/home/vagrant/.config" ] && mkdir /home/vagrant/.config
[ -d "/home/vagrant/.config/i3" ] && rm -r /home/vagrant/.config/i3
cp -r /vagrant/.Provisioning/.config/i3 /home/vagrant/.config/
[ -d "/home/vagrant/.config/xfce4" ] && rm -r /home/vagrant/.config/xfce4
cp -r /vagrant/.Provisioning/.config/xfce4 /home/vagrant/.config/

