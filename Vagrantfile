# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "public_devbox"
  config.vm.box = "generic/ubuntu2204"
  config.vm.hostname = "devbox"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = "8"
    vb.gui = "true"
    vb.memory = "8192"
    vb.name = "Linux devbox"

    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["modifyvm", :id, "--description", "Linux Development Box"]
    vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
    vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
    vb.customize ["modifyvm", :id, "--vram", "128"]
    vb.customize ["modifyvm", :id, "--vrde", "off"]

    vb.customize ["storageattach", :id, "--port", "0", "--device", "0", "--storagectl", "IDE Controller", "--type", "dvddrive", "--medium", "emptydrive", "--mtype", "readonly"]
  end

  #config.vm.synced_folder "<Windows-side full path>", "/home/vagrant/<path>"

  # --- basic setup --- #
  config.vm.provision "timezone", type: "shell", inline: "timedatectl set-timezone Europe/Helsinki"

  config.vm.provision "ubuntu-update", type: "shell", run: "once", inline: <<-SHELL
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y 
    apt-get autoremove -y
  SHELL

  # --- essentials --- #
  config.vm.provision "ubuntu-desktop", type: "shell", run: "once", inline: "apt-get install -y ubuntu-desktop"
  config.vm.provision "c-essentials", type: "shell", run: "once", inline: "apt-get install -y build-essential libtool libtool-doc autoconf autoconf-doc automake make-doc cpp-doc bzip2-doc clang clang-format cmake cmake-format cmake-doc gcc-doc gdb gdb-doc gdbserver flex flex-doc bison bison-doc"
  #config.vm.provision "java-essentials", type: "shell", run: "once", inline: "apt-get install -y default-jre default-jdk-headless junit4 maven"
  config.vm.provision "scm-toolchain", type: "shell", run: "once", inline: "apt-get install -y git-lfs gitg meld kdiff3 subversion"
  config.vm.provision "misc-utils", type: "shell", run: "once", inline: "apt-get install -y cloc dos2unix tree"
  #config.vm.provision "misc-dev-tools", type: "shell", run: "once", inline: "apt-get install -y graphviz graphviz-doc gsfonts"

  # --- IDEs --- #
  #config.vm.provision "android-ide", type: "shell", run: "once", inline: "snap install android-studio --classic"
  #config.vm.provision "eclipse-ide", type: "shell", run: "once", inline: "snap install eclipse --classic"
  #config.vm.provision "vscode-ide", type: "shell", run: "once", inline: "snap install code --classic"

  # --- Tools --- #
  #config.vm.provision "firefox", type: "shell", run: "once", inline: "snap install firefox"
  #config.vm.provision "postman", type: "shell", run: "once", inline: "snap install postman"

  # --- configuration --- #
  config.vm.provision "file", source: ".bash_aliases.src", destination: "~/.bash_aliases", run: "once"
  config.vm.provision "file", source: ".gitconfig.src", destination: "~/.gitconfig", run: "once"

  config.vm.provision "user-setup", type: "shell", run: "once" do |s|
    s.path = "./user-setup.sh"
  end

  config.vm.provision "shutdown", type: "shell", run: "once", inline: "shutdown now 'Shutting down ...'"

  # --- end provisioners ---

end
