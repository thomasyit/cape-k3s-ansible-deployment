#!/bin/bash
touch /tmp/test1
echo date >> /tmp/test1
#sudo su - root
setenforce 0
/bin/mv /root/.ssh/id_rsa* /tmp/


ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""



cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y git ansible
git clone https://github.com/cape-sh/cape-k3s-ansible-deployment.git

cd cape-k3s-ansible-deployment/


PvtIP=`hostname -i`
PubIP=`curl https://api.ipify.org/`
sed -i  "s#server_master_ip#$PvtIP#g"  inventory/hosts.ini
sed  -i "s#server_master_ip#$PubIP#g"  roles/cape/tasks/main.yml
ansible-playbook site.yml
echo date >> /tmp/test1
