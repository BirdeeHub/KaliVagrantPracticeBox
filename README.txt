Ethical Hacking Practice Kali VM for Windows
Requirements: Vagrant and VirtualBox


**ATTENTION**
NEEDS TO BE PLACED IN HOME FOLDER FOR CopyOVPN.bat AND CopySSH.bat TO FUNCTION PROPERLY 
(and by extension, VSCode_environment.bat will also not work as it calls these 2 scripts)
**/ATTENTION**

vm start in gui and headless done through the .bat files in .vm_ctl
headless start batch file runs vagrant up (if not running) and ssh (over 127.0.0.1:2202)
gui start runs vagrant up (if not running) and then: start "" "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm birdeeKali --type separate

shortcuts already made in .vm_ctl/KaliVMStart/
icons for shortcuts inside .vm_ctl/KaliVMStart/icons

docker-compose.yml file contains many different practice server programs to use. 
Simply uncomment 
(and uncomment associated port forwarding rule(assuming you want to access the from your host browser ever, such as when running from headless mode)),
then:
cd ~; docker-compose up;
note: the different shellshock containers have the same port forward rule, so be careful with that.

VSCode_environment runs the batch files CopyOVPN.bat and CopySSH.bat from the .Provisioning folder, 
which will copy your current ssh public key, and openvpn config files to the .Provisioning folder.
it will also open VSCode for this directory, as well as the host file so that you can edit it while doing hack the box

This box is for practicing ethical hacking skills on various different platforms. 
I own nothing in this repository. 
It is entirely a combination of various practice tools and materials that I have found and used.
My only contribution is writing a few batch files, a vagrantfile that provisions everything, and collecting everything in one place.

Git clone, click a batch file (or make a new tab in windows terminal that runs the .HeadlessKaliStart.bat from the correct starting directory)
Then thats it! Once it provisions you will have everything you need to start practicing!

This is more or less a list of all the non SIEM programs that I have gotten a decent amount of use for 
so far in the pentesting category of activities that arent already in kali like burpsuite etc.
It also has some I haven't used much yet but am checking out.