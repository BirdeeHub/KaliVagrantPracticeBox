Ethical Hacking Practice Kali VM for Windows
Requirements: Vagrant and VirtualBox


**ATTENTION**
THIS BOX IS NOT ITSELF SECURE
this box is for practice purposes. the contained practice images 
are not easily accessible from the outside internet as host communication 
uses specific port forwarding over loopback interface, but if an entity
is able to gain control of the box, with a shared folder and default password it 
would be extremely easy to gain access to the host. Changing the password only slightly helps with this.
Although it does help so you should definitely change the password.
You would need to remove the vagrant provisioning key from authorized_keys, remove shared folders, 
set up firewalls and/or antivirus solution, make sure nothing is running with SUID root that 
doesnt need it, set password and lockout policies, make it so the provisioning scripts no longer run as root, 
and much more. 
The ssh key change in particular would break vagrant up provisioning unless i wanted to package this as its own box.
You also would absolutely not want to expose DVWA to the general internet obviously.

You can put this repository wherever you want, but the relevant config files 
for openvpn and .ssh and firefox must be in their default windows locations for 
CopyOVPN.bat AND CopySSH.bat AND CopyFireFox.bat to function properly.
(and by extension, VSCode_environment.bat will also not work as it calls these 3 scripts)
these scriptswill not run on their own without path edits. 
The intention is for you to use 
VSCode_environment.bat to run all 3 and open VSCode.

In order to copy firefox configuration, it requires you to open firefox in the vm,
and then close it again, and then run the script /home/vagrant/copy_firefox.sh.
This is because you need a profile to copy the settings to.

For Mac and Linux hosts:
You will need to edit the batch files to be bash scripts 
and replace paths with correct paths to use them on linux or mac hosts.
They are all much easier to write in bash because you can actually 
set a variable to the output of a piped command without a loop.
You will also need to change \\ to / in the vagranfile
where it calls the provisioning scripts.
**/ATTENTION**

vm start in gui and headless done through the .bat files in .vm_ctl
headless start batch file runs vagrant up (if not running) and ssh (over 127.0.0.1:2202) 
(headless start batch file can be added to windows terminal tabs, remember to set starting directory to repository root directory)
gui start runs vagrant up (if not running) and then: start "" "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" startvm birdeeKali --type separate

shortcuts already made in .vm_ctl/KaliVMStart/
icons for shortcuts inside .vm_ctl/KaliVMStart/icons

docker-compose.yml file contains many different practice server programs to use. 
Simply uncomment 
(and uncomment associated port forwarding rule(assuming you want to access the from your host browser ever, such as when running from headless mode)),
then:
cd ~; docker-compose up;
note: the different shellshock containers have the same port forward rule, but one of them only needs 1 of the rules turned on.

VSCode_environment runs the batch files stored in the .Provisioning\setup_host_env\ folder, 
which will copy your current ssh public key, and openvpn config files to the .Provisioning folder.
it will also open VSCode for this repository, as well as the host file so that you can edit it easily while doing hack the box

This box is for practicing ethical hacking skills on various different platforms. 
I own nothing in this repository. 
It is entirely a combination of various practice tools and materials that I have found and used.
My only contribution is writing a few batch files, a vagrantfile that provisions everything, and collecting everything in one place.

Git clone, click a batch file (or make a new tab in windows terminal that runs the .HeadlessKaliStart.bat from the correct starting directory)
Then thats it! Once it provisions you will have everything you need to start practicing!

This is more or less a list of all the non SIEM programs that I have gotten a decent amount of use for 
so far in the pentesting category of activities that arent already in kali like burpsuite etc.
It also has some I haven't used much yet but am checking out.