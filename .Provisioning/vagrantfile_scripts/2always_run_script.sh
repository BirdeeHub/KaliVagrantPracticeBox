#!/bin/bash
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
