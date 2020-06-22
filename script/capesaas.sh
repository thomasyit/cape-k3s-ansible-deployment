#!/bin/bash
touch /tmp/test1
#sudo su - root
setenforce 0
/bin/mv /root/.ssh/id_rsa* /tmp/
touch /tmp/test2

ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""

touch /tmp/test3

cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y git ansible
git clone https://github.com/cape-sh/cape-k3s-ansible-deployment.git
sleep 5 
cd cape-k3s-ansible-deployment/
touch /tmp/test4

PvtIP=`hostname -i`
PubIP=`curl https://api.ipify.org/`
sed -i  "s#server_master_ip#$PvtIP#g"  inventory/hosts.ini
sed  -i "s#server_master_ip#$PubIP#g"  roles/cape/tasks/main.yml
ansible-playbook site.yml
touch /tmp/test5
