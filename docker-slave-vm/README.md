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

Once inside the vm, enter this command :

```
    sudo vim Dockerfile
```

It will open a new blank document. You have to paste inside the content of the dockerfile you fetched from the repo. (Press i keyboard letter to pass in INSERT mode, then use right click to paste). Save and exit the file by typing :wq and hit enter.

You can now build the docker image, from this dockerfile, that will be use by jenkins host to runs its pipeline :

```
sudo docker build -t jenkins-slave-docker -p 2222:22
```
