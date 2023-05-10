#!/bin/bash
echo
echo Adding Aliases to .zshrc file...
echo "alias gobuckets='gobuster vhost -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -u \$1'" >> /home/vagrant/.zshrc
echo "alias srvsnake='sudo python3 -m http.server \$1'" >> /home/vagrant/.zshrc
echo "alias ovpn='sudo openvpn \$1'" >> /home/vagrant/.zshrc
echo "alias SCVnmap='sudo nmap -vv -sSCV -T4 \$1'" >> /home/vagrant/.zshrc
echo "alias SCVnmap-p-='sudo nmap -vv -sSCV -p- -T4 \$1'" >> /home/vagrant/.zshrc
echo "alias gobusdir='gobuster dir -w /usr/share/wordlists/dirbuster/directory-list-1.0.txt -u \$1'" >> /home/vagrant/.zshrc
echo "alias THMssh='ssh -oHostKeyAlgorithms=+ssh-rsa \$1'" >> /home/vagrant/.zshrc

echo "function dirffufle() {local cnt=0; local xtraargs=(); for arg in \"\$@\"; do let \"cnt+=1\"; [[ \$cnt > 1 ]] &&  xtraargs+=(\"\$arg\"); [[ \$cnt == 1 ]] && local url=\"\$arg\"; done; local full_command=\"sudo ffuf -w /usr/share/wordlists/dirbuster/directory-list-1.0.txt -u \$url/FUZZ \$xtraargs\"; echo \"\$full_command\"; bash -c \"\$full_command\"; }" >> /home/vagrant/.zshrc

##with ffufbucket, you will want to use -mc all and figure out the default response, and then -mc the,different,codes; #With gobuckets alias, this is not necessary as gobuster does it for you.
echo "function ffufbucket() {local cnt=0; local xtraargs=(); for arg in \"\$@\"; do let \"cnt+=1\"; [[ \$cnt > 2 ]] &&  xtraargs+=(\"\$arg\"); [[ \$cnt == 1 ]] && local url=\"\$arg\"; [[ \$cnt == 2 ]] && local domain=\"\$arg\"; done; local full_command=\"sudo ffuf -H 'Host: FUZZ.\$domain' -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -u \$url \$xtraargs\"; echo \"\$full_command\"; bash -c \"\$full_command\"; }" >> /home/vagrant/.zshrc
