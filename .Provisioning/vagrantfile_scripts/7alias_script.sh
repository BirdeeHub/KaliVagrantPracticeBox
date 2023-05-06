#!/bin/bash
echo
echo Adding Aliases to .zshrc file...
echo "alias gobuckets='gobuster vhost -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt --append-domain -u $1'" >> /home/vagrant/.zshrc
echo "alias srvsnake='sudo python3 -m http.server $1'" >> /home/vagrant/.zshrc
echo "alias ovpn='sudo openvpn $1'" >> /home/vagrant/.zshrc
echo "alias SCVnmap-p-='sudo nmap -vv -sSCV -p- -T4 $1'" >> /home/vagrant/.zshrc
echo "alias gobusdir='gobuster dir -v -w /usr/share/wordlists/dirbuster/directory-list-1.0.txt -u $1'" >> /home/vagrant/.zshrc
echo "alias THMssh='ssh -oHostKeyAlgorithms=+ssh-rsa $1'" >> /home/vagrant/.zshrc