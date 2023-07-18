# Jenkins virtual machine

## How to launch and configure jenkins

### Installation

Make sur you have Vagrant installed on your laptop
Inside a terminal, enter the following command :

```
  git clone https://github.com/SimonMartinenq/DevOps.git
  cd jenkins-vm
  vagrant up
```

When virtual machine installation is done, you will see a password display in the your terminal : copy it.

Keep this terminal up because a process is running to listen from github webhook in order to trigger pipeline when code is committed. As the github webhook is not able to call directly our jenkins (because it runs on localhost and don't have public ip) we've use a proxy to transfer the webhook call from github to our local jenkins instance

Now open your browser and type :

```
http://localhost:8080
```

You will be ask to enter jenkins credentials to connect to the web portal. Username is "admin", password is the one just copied

### Credentials configuration

Go to manage jenkins > Credentials > System > Global ID > Add Credentials :

Username : jenkins\
Password : password

### Docker slave Configuration

Go to manage jenkins > Nodes and Clouds > Clouds > Add a cloud and fill the form with the following infos :

#### Docker Cloud details

Name : docker\
Docker Host URI : tcp://192.168.56.101:4243\
Server credentials : none

#### Docker Agent templates

Labels : docker-slave\
Docker Image : jenkins-slave-docker\
Connect method : Connect with SSH\
SSH key : Use configured SSH credentials\
SSH Credentials : select the jenkins user/password credentials

Save

#### Pipeline configuration

Create a new Item > pipeline > give the name you want\
In Build Triggers section, select GitHub hook trigger for GITScm polling

In pipeline section :

Definition : Pipeline script from SCM\
SCM : Git\
Repository URL : https://github.com/SimonMartinenq/DevOps \
Branches to build : \*/fullstack-app\
Script Path : application/Jenkinsfile

Save

### Pipeline execution

From now, each time the branch fullstack-app of the repo is modified, the pipeline will be triggered.
You can also manually launche the pipeline by clicking 'Launch a build' on the pipeline.

If you want the pipeline to succeed, you need also to install and configure [docker-slave-vm](https://github.com/SimonMartinenq/DevOps/blob/fullstack-app/docker-slave-vm/README.md) and [server-deployment-vm](https://github.com/SimonMartinenq/DevOps/blob/fullstack-app/server-deplyment-vm/README.md)
