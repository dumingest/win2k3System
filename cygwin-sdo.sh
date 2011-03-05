#!/bin/sh
# author:   yanglei@snda.com
# create:   2010-11-21
# modified: 2011-1-30

# set directory authority
chmod -R 755 /cygdrive/c/cygwin/
chown -R Administrators.None /cygdrive/c/cygwin/

# user permission set up
mkpasswd -l > /etc/passwd
mkgroup -l > /etc/group
chmod 644 /etc/passwd
chmod 644 /etc/group

# public key set up
mkdir ~/.ssh
chmod 700 ~/.ssh
mv /home/authorized_keys ~/.ssh
chmod 600 ~/.ssh/authorized_keys

# set up git private key
mv /home/id_rsa ~/.ssh
chmod 600 ~/.ssh/id_rsa

# make sure Administrator owns files
smart_chown()
{
	cd ~
	CHOWN_HOME=`pwd`
	CHOWN_USER=`basename $CHOWN_HOME`
	echo "chown -R ${CHOWN_USER} ${CHOWN_HOME}"
}
smart_chown

#run modified ssh-host-config
chown -R Administrators.None /var
mv /home/ssh-host-config /usr/bin
chmod +x /usr/bin/ssh-host-config 
ssh-host-config -y

chown -R cyg_server.None /var/empty

# start shd servivce
net start sshd-ng
