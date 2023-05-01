#!/bin/bash
profile_path="/home/vagrant/.mozilla/firefox/$(cat /home/vagrant/.mozilla/firefox/profiles.ini | grep -P "Default=.*\..*" | awk -F "=" '{print $2}')/"
rm -r $profile_path/*
cp -r /vagrant/.Provisioning/firefox/* $profile_path