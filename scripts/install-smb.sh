#!/bin/bash
apt-get install -y samba git zip unzip vim
sed -i 's/;   interfaces = 127.0.0.0\/8 eth0/interfaces = eth1/g' /etc/samba/smb.conf
systemctl enable smbd.service
systemctl start smbd.service
systemctl enable nmbd.service
systemctl start nmbd.service
cp /vagrant/projects/* /home/project/projects

