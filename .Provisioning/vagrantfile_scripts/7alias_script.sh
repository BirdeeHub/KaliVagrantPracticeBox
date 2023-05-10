#!/bin/bash
echo
echo Adding Aliases to .zshrc file...
echo "alias gobuckets='gobuster vhost -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -u $1'" >> /home/vagrant/.zshrc
echo "alias srvsnake='sudo python3 -m http.server $1'" >> /home/vagrant/.zshrc
echo "alias ovpn='sudo openvpn $1'" >> /home/vagrant/.zshrc
echo "alias SCVnmap-p-='sudo nmap -vv -sSCV -p- -T4 $1'" >> /home/vagrant/.zshrc
echo "alias gobusdir='gobuster dir -w /usr/share/wordlists/dirbuster/directory-list-1.0.txt -u $1'" >> /home/vagrant/.zshrc
echo "alias THMssh='ssh -oHostKeyAlgorithms=+ssh-rsa $1'" >> /home/vagrant/.zshrc

echo "function dirffufle() {local cnt=0; local xtraargs=(); for arg in \"\$@\"; do let \"cnt+=1\"; [[ \$cnt != 1 ]] &&  xtraargs+=(\"\$arg\"); [[ \$cnt == 1 ]] && local domain=\"\$arg\"; done; local full_command=\"sudo ffuf -c -w /usr/share/wordlists/dirbuster/directory-list-1.0.txt -u http://\$domain/FUZZ \$xtraargs\"; bash -c \"\$full_command\"; }" >> /home/vagrant/.zshrc
