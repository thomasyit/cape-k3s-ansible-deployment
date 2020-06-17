# Deploy CAPE and kubernetes with docker


## What this playbook will do when you execute it :

1. It will configure all Prerequisites for CentOS7/RHEL7 eg: selinux , firewall disable etc..
2. It will Autoconfigure all installable repo for Kubernetes
    *For RHEL7 , please enable your Redhat subscription or connect to local repo so dependent packages can be installed
3. It will install Packages like : k3s , Docker , crictl
4. CAPE application will be installed
5. It will enable access to CAPE gui via URL


# How to use this repo to deploy

Terminology
```
HOST - refers to your laptop or server where ansible exists
Your_server_master_ip - refers to your machine/server IP where you want CAPE and Kubernetes to be installed.

In case if your HOST and <Your_server_master_ip> is same machine instead of ip you can use:  localhost
```

### Download this repo to HOST.(Host should have Ansible and Git installed)

To Install Ansible in your host:  
https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

To Install GIT: 
https://git-scm.com/downloads

Then Proceeed with below: 
```
git clone https://github.com/biqmind/Cape-K3S-ansible-deployment.git 
```
>> change directory to the git repo directory.

```
cd Cape-K3S-ansible-deployment/
```


### Prepare password less root ssh to your <Your_server_master_ip> from your HOST  :
```

ssh-copy-id root@<Your_server_master_ip>
```
> Example:
```
   : ssh-copy-id root@192.168.100.110 
```


Replace <Your_server_master_ip> with  your server ip in files below.

#### Linux OS :
```
sed -i  's/server_master_ip/<Your_server_master_ip>/g'  inventory/hosts.ini

sed -i  's/server_master_ip/<Your_server_master_ip>/g'  roles/cape/tasks/main.yml
```

Example of above afetr replacing ip should look like this:

```
sed -i  's/server_master_ip/192.168.100.110/g'  inventory/hosts.ini 
sed -i  's/server_master_ip/192.168.100.110/g'  roles/cape/tasks/main.yml 
```

#### MAC OS:
```
sed -i'bk' -e    's/server_master_ip/<Your_server_master_ip>/g'  inventory/hosts.ini  
 
sed -i'bk' -e    's/server_master_ip/<Your_server_master_ip>/g' roles/cape/tasks/main.yml
```


## Verify if IP was updated properly in both files:

```
grep -i <Your_server_master_ip> inventory/hosts.ini  

grep -i <Your_server_master_ip> roles/cape/tasks/main.yml
```

You should see the ip updated in these files.

## Got issues in updating IP ??

Replace <Your_server_master_ip> (search for string "server_master_ip" ) manually in below 2 location :

> inventory/hosts.ini  (Line number 2)

> roles/cape/tasks/main.yml (Line number 27)


## Run End to End deployment now to get a running CAPE
```
ansible-playbook site.yml

```
## Wait for few minutes till you see all pods are up

```
ssh root@<your_server_ip>
kubectl get pods -n cape
```

Make sure all pods are in healthy state else kill that pod and it will restart in few seconds

# Now Access Cape GUI 


> URL
```

 http://<Your_server_ip>.nip.io/
```

** Refer to cape documentation on how to use CAPE **


# Encountered issues and want to reset everything 

> Run this playbook to uninstall kubernetes and crictl
```
 ansible-playbook reset.yml
```







