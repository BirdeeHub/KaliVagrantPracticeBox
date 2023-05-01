#!/bin/bash
echo
echo Adding Aliases to .zshrc file...
echo "alias gobuckets='gobuster vhost -w ~/git_repos/SecLists/Discovery/DNS/subdomains-top1million-5000.txt --append-domain -u '" >> /home/vagrant/.zshrc
