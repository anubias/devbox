Linux Development Box
=====================
This document describes how to install and use the Linux Development Box. The development box is based on Vagrant and VirtualBox. Currently it is based on the **Ubuntu 22.04 LTS** (Long Term Support).

Downloading necessary tools
---------------------------
Please download and install the following components:
* [Vagrant](https://www.vagrantup.com/downloads) - latest version recommended
* [VirtualBox](https://www.virtualbox.org) - latest version recommended

These components will be separately and independently upgradeable later on, without any impact on the development box.

The virtual image itself will be installed at a later phase.

VirtualBox setup
----------------
In order to have an easy to maintain setup, it is important to have a properly configured VirtualBox product.

1. Launch the **VirtualBox Manager**, and open the **File->Preferences** menu item
2. In the **General section**, select a directory where the various virtual images will be stored by VirtualBox. Make sure you have enough space on the disk or partition which you will use to store the virtual image(s). A good estimate for the space needs is to have around 100GB free for each separate box you want to setup.
3. Try not to change other settings, unless you really know what you're doing. The default values should be good enough for most use-cases.

Configuration
-------------

First thing to note is that we have several files which we can modify:
* **Vagrantfile**: contains the vagrant-specific configuration; it is the starting point of setting up the development box
* **.gitconfig.src**: is a file which contains some special git specific aliases which may come handy
* **user-setup.sh**: is a bash shell file, which will be executed on the freshly created development box, and which helps setup some specific settings
* **.bash_aliases.src**: is a file which will be copied to your development box and contains any useful bash aliases you prefer to use

So **before installing the development box**, let's customize the configuration. Use your favorite text editor to modify the next files:

1. First step is to clone this repository to your local computer.
2. Edit the **Vagrantfile** file:
    - Multi devbox considerations. If you want to have multiple devbox machines installed in parallel, check the instructions under this section. Otherwise, you can skip to the next step.
        - Make sure that the entry **"config.vm.define"** is unique between your different devbox-es. This id identifies each virtual image to VirtualBox.
	    - At the same time, it is also important to keep the **"vb.name"** unique as well, so that the VirtualBox can more easily manage the various metadata directories for each machine. The easiest way is to keep this setting in sync with **config.vm.define** (above)
    - Next, inspect and modify if needed the values of **"vb.cpus"** and **"vb.memory"**. These are telling VirtualBox how many CPUs to expose to and how much RAM to reserve for the devbox. Modify according to your needs.
	- In case you wish to have a shared directory between the host OS (Windows) and the devbox, locate the line configuring the **"config.vm.synced_folder"**, uncomment the line if needed (by removing the leading # character) and fill-in the appropriate Windows-side and Linux-side paths which will act as a shared (synced) directory.
	- Locate the **"timezone"** line in the file, and change it to your needs. For an exhaustive list of valid **"TZ identifiers"**, please refer to this page: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
	- Finally, inspect the various **essentials**, **IDEs** and **Tools** entries in the file and enable/disable the ones you need. Keeping this minimal helps with shortening installation times. The configuration is minimalistic, so it's not recommended to comment away tools, unless you know what you are doing.
3. The **.git-config.src** file needs to be properly filled in with your name, e-mail address and optionally your favorite commit editor. Feel free to add more configurations to that file, if you prefer. That file will end up being copied to the virtual image during installation, as such you will also be able improve it in-place later on, after devbox installation.
4. Inspect and update the **.bash_aliases.src** file with your favorite aliases for a productive experience.
5. Optionally you can also control more advanced settings in the **"user-setup.sh"** file. It is expected you know what you're doing here, so have fun!

Installation
------------
Installation is very straightforward. Open a Windows terminal window in the vagrant directory created during the Configuration step, and execute **vagrant up** command.

This operation will take a while, so go get a warm cup of coffe or tea and arm yourself with patience.

Vagrant will start provisioning the specified Ubuntu image, and then executing the installation procedure described in the Vagrantfile. During the installation, a new VirtualBox instance will be automatically started with the new image. You will be able to observe the progress of the installation from the Windows terminal window.

After installation, the virtual image will be shut down. You can then start it from the VirtualBox Manager window (easiest), or by re-running the "vagrant up" command from the terminal.

Once the machine has started, you can login the system using the **vagrant** word for both username and password. Avoid changing it, for forward compatibility.

If later on you want to update the image, you may do so by running **vagrant up --provision** from the Windows terminal opened in the same directory. You can also update the image from within, by using the **apt** utility.

Guest additions
---------------
The very last step after installation (and also after Linux kernel updates), it is recommended to update the **guest additions**. These are a set of kernel modules that allow seamless integration of the guest OS (Ubuntu) with the host OS (Windows). These additions cover aspects like integrating mouse, graphics, USB and other auxiliary devices. In fact, you will notice that without this step, you won't really be able to easily change the resolution of the devbox.

To do that, follow the next steps:
1. In the Devbox window itself (not within the hosted OS), locate the system menu and select **Devices -> Insert Guest Additions CD image**
2. Wait a short while until a CD image appears on the left-hand task bar inside Ubuntu
3. Once the icon appears, hover over it and you should see a tooltip similar to **"VBox_GAs_###"**, with the ### characters denoting a particular version
4. Open a terminal window in Ubuntu (Ctrl+Alt+T) and in it navigate to the **/media/vagrant/VBox_GAs_###** directory
5. Once there, execute **sudo ./VBoxLinuxAdditions.run**
6. If prompted, type **yes**
7. After installation is successful, shutdown the devbox and restart it
