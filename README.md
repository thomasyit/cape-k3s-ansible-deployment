# Deploy CAPE and Kubernetes with Docker


## When you execute this playbook, it will:

1. Configure all prerequisites for CentOS7/RHEL7 eg: SELinux , disable firewall etc.
2. Autoconfigure all installable repos for Kubernetes
> *For RHEL7, please enable your Red Hat subscription or connect to a local repo so that dependant packages can be installed*
3. Install packages like k3s , Docker , crictl
4. Install the CAPE application
5. Enable access to CAPE GUI via URL


## How to use this repo to deploy

Terminology
```
HOST - refers to the machine or server where Ansible exists
<Your_server_master_ip> - refers to the machine/server IP where you want to install CAPE and Kubernetes

If the HOST machine and the <Your_server_master_ip> machine is same, you can use 'localhost' instead of the machine/server IP.
```


### Download this repo to HOST (host should already have Ansible and GIT installed)

To install Ansible:  
https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

To install GIT: 
https://git-scm.com/downloads

Once Ansible and GIT are installed proceeed with the following: 

```
git clone https://github.com/biqmind/Cape-K3S-ansible-deployment.git 
```

> Change directory to the git repo directory

```
cd Cape-K3S-ansible-deployment/
```


### Prepare password less root ssh to your <Your_server_master_ip> from your HOST:

```bash
ssh-copy-id root@<Your_server_master_ip>
```
> Example:
```bash
ssh-copy-id root@192.168.100.110 
```

Replace <Your_server_master_ip> with  your server IP in the files listed below:

#### Linux OS :

```bash
sed -i  's/server_master_ip/<Your_server_master_ip>/g'  inventory/hosts.ini
sed -i  's/server_master_ip/<Your_server_master_ip>/g'  roles/cape/tasks/main.yml
```

After the replacing the IP, it should look like this:

```bash
sed -i  's/server_master_ip/192.168.100.110/g'  inventory/hosts.ini 
sed -i  's/server_master_ip/192.168.100.110/g'  roles/cape/tasks/main.yml 
```

#### MAC OS:

```
sed -i'bk' -e    's/server_master_ip/<Your_server_master_ip>/g'  inventory/hosts.ini  
sed -i'bk' -e    's/server_master_ip/<Your_server_master_ip>/g' roles/cape/tasks/main.yml
```


### Verify the the IP was updated properly

You should see the IP updated in these files:
```bash
grep -i <Your_server_master_ip> inventory/hosts.ini  

grep -i <Your_server_master_ip> roles/cape/tasks/main.yml
```


### Issues with updating the IP

Replace <Your_server_master_ip> (search for string "server_master_ip" ) manually in the following 2 locations:

> inventory/hosts.ini  (Line number 2)

> roles/cape/tasks/main.yml (Line number 27)


### Now run an end-to-end deployment to get CAPE running

```bash
ansible-playbook site.yml
```


### Wait for a few minutes until you see that all pods are up, then

```bash
ssh root@<your_server_ip>
kubectl get pods -n cape
```
Make sure all pods are in a healthy state else kill any unhealthy pods and they will restart in few seconds


### Now access the CAPE GUI 

> URL
```
http://<Your_server_ip>.nip.io/
```
** All CAPE documentation is available [here](https://docs.cape.sh/docs/) **


### To reset everything 

> Run this playbook to uninstall Kubernetes and crictl
```bash
ansible-playbook reset.yml
```

## Getting Started with CAPE

Get started quickly using this [tutorial](https://docs.cape.sh/docs/simple-install)


## Getting Involved

We appreciate your feedback and active participation.

If you want to get in touch with us to discuss improvements and new
features, please [create a new issue on GitHub][1] or connect with us over on Slack:

* [`#general` Slack channel](https://capesh.slack.com)

## Reporting Bugs

If you encounter a bug, please [create a new issue on GitHub](https://github.com/cape-sh/cape/issues/new) or talk to us
on our [`#general` Slack channel](https://capesh.slack.com). When reporting a bug please include the
following information:






