#!/bin/bash
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
git clone https://github.com/DominicBreuker/pspy.git /home/vagrant/git_repos/pspy
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
git clone https://github.com/eversinc33/JailWhale.git /home/vagrant/git_repos/JailWhale
git clone https://github.com/1N3/Sn1per.git /home/vagrant/git_repos/Sn1per
git clone https://github.com/veracode-research/rogue-jndi /home/vagrant/git_repos/rogue-jndi \
&& mvn package -f /home/vagrant/git_repos/rogue-jndi

# if you need other linpeas and dont want to compile you can edit this command
wget -O /home/vagrant/git_repos/PEASS-ng/winPEASx64.exe https://github.com/carlospolop/PEASS-ng/releases/download/refs%2Fpull%2F260%2Fmerge/winPEASx64.exe