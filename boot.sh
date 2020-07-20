#!/bin/bash

apt-get -y install ssh
apt-get -y install ansible

sed -i '/efi/d' /etc/fstab
sed -i '/home/d' /etc/fstab

umount /dev/sda1
umount /dev/sda3

mkdir ~/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCqfal6XdwNCSAnWsIA73mWBA0mdF26bKdcDB4MpVHEypomd69iEjNO0Vdx+ut+Y+kf3K6aBTd8vg9WoqpMpv4lnwo0iOsH6KMOeFnB9Pj22GFQaFtum7VGRb1RQ9u6gg5hixYe2Yk1ui7LgfZUQqqyh2PkaBeFpXoeYOWYvXsOxMOqtVAF6K0g1dYJEL0VeYDxHQlP8CAuQv1KkUqYDxkJSg9U+iO+Tjvez6aau/Nw6ynXdlyZxUX+om/xspInUJy9sAimvQ3icrC5EMFyKJica0eVB48VfGuKFyRnIbVAUhXBfSJ+n4s9waUdW+RhlNcxh9Qgqs3snbqaC9ipDB3n omarzorob@Omars-MacBook-Pro.local" >> ~/.ssh/authorized_keys

sed -e 's|overlayroot=""|overlayroot="device:dev=/dev/sda3,timeout=180"|' /etc/overlayroot.conf > tmp.txt
cp tmp.txt /etc/overlayroot.conf

wget https://raw.githubusercontent.com/ozorob2/late_command_pub/master/install-docker-and-nvidia.yml
ansible-playbook install-docker-and-nvidia.yml

rm /etc/rc.local
reboot
