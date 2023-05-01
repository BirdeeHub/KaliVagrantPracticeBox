#!/bin/bash
echo
echo Creating SSH Keys...
runuser -l vagrant -c 'ssh-keygen -f /home/vagrant/.ssh/id_rsa -t rsa -N ""'
chmod 600 /home/vagrant/.ssh/id_rsa
chmod 644 /home/vagrant/.ssh/id_rsa.pub