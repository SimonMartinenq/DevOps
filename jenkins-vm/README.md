# Jenkins virtual machine

## How to launch jenkins

### Installation

Make sur you have Vagrant installed on your laptop
Inside a terminal, enter the following command :

```
  git clone https://github.com/SimonMartinenq/DevOps.git
  cd jenkins-vm
  vagrant up
```

Keep this terminal up because a process is running to listen from github webhook in order to trigger pipeline when code is committed. As the github webhook is not able to call directly our jenkins (because it runs on localhost and don't have public ip) we've use a proxy to transfer the webhook call from github to our local jenkins instance

Now open your browser and type :

```
http://localhost:8080
```

The configuration and plugins installation of jenkins is done automatically using jenkins configuration as code plugin. The plugin use the jenkins.yaml config file to set up jenkins, and create a jenkins account.

You will be ask to enter jenkins credentials to connect to the web portal. Username is "jenkins-admin", password is "admin".

### Pipeline execution

Once connected, a pipeled should already be present and configured. You can launches it manually by clicking on the "start a build button" or by commiting code on the github repository

If you want the pipeline to succeed, you need also to install and configure [docker-slave-vm](https://github.com/SimonMartinenq/DevOps/blob/fullstack-app/docker-slave-vm/README.md) and [server-deployment-vm](https://github.com/SimonMartinenq/DevOps/blob/fullstack-app/server-deplyment-vm/README.md)
