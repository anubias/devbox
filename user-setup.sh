#!/bin/bash

#defines
VAGRANT_NAME=vagrant
VAGRANT_HOME=/home/${VAGRANT_NAME}
BASHRC=${VAGRANT_HOME}/.bashrc
BASHRC_NEW=${VAGRANT_HOME}/.bashrc_new


if [ ! -f ${BASHRC} ]; then
  sudo cp /etc/skel/.bashrc ${BASHRC}
fi


#changing PS1 to
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\][\[\033[00;32m\]\t\[\033[00m\]] \[\033[01;34m\]\w\[\033[00m\]\[\033[01;35m\]$(__git_ps1 " (%s)")\[\033[00m\] \$ '
line=`grep -n "if \[ \"\\$color_prompt\" = yes \]; then" ${BASHRC} | sed s/:.*/""/`
if [ ! -z ${line} ]; then
  sudo head -n ${line} ${BASHRC} > ${BASHRC_NEW}
  sudo echo "    PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\][\[\033[00;32m\]\t\[\033[00m\]]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;35m\]\$(__git_ps1 \" (%s)\")\[\033[00m\] \\\$ '" >> ${BASHRC_NEW}
  line=`expr ${line} + 2`
  sudo tail -n +${line} ${BASHRC} >> ${BASHRC_NEW}
  sudo mv -f ${BASHRC_NEW} ${BASHRC}
fi


#Configuring "US" keyboard layout
#grep "setxkbmap" ${BASHRC}
#if [ $? = 1 ]; then
#  sudo echo "" >> ${BASHRC}
#  sudo echo "setxkbmap us" >> ${BASHRC}
#fi


#copy preferences
for f in '.bash_aliases' '.gitconfig'
do
  sudo dos2unix ${VAGRANT_HOME}/"$f"
done

sudo chown ${VAGRANT_NAME}.${VAGRANT_NAME} ${BASHRC}

#cleaning any crash reports
sudo rm -f /var/crash/*


exit 0
