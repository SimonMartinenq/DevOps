# Docker slave virtual machine

## How to configure the slave node for jenkins

### Installation

Make sur you have Vagrant installed on your laptop
Inside a terminal, enter the following command :

```
  git clone https://github.com/SimonMartinenq/DevOps.git
  cd docker-slave-vm
  vagrant up
```

When virtual machine installation is done connect to the vm using :

```
  vagrant ssh
```

Once inside the vm, enter this command to build the image that jenkins host will use to dynamically create containers for running pipeline jobs:

```
    sudo docker build -t pierre15602/jenkins-slave-docker:latest -p 2222:22
```
