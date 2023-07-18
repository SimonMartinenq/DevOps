#!/bin/bash

#"Adding apt-keys"
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# "Updating apt-get"
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get upgrade -y

#  "Installing java"
sudo apt install -y openjdk-11-jre
java -version

# "Installing git"
sudo apt-get -y install git

# "Installing git-ftp"
sudo apt-get -y install git-ftp

# "Installing nodejs and npm"
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# "Installing webhookRelay and log into" 
curl https://my.webhookrelay.com/webhookrelay/downloads/install-cli.sh | bash
relay login -k e6ebbe7b-ce2c-4871-9b8b-44bf0a87ca44 -s QNvQI8oRpDK2

# "Installing jenkins"
sudo apt-get install -y --allow-unauthenticated jenkins
sudo service jenkins start

# "Installing Jenkins Config as Code plugin"
sudo curl -fsSLo /var/lib/jenkins/plugins/configuration-as-code.hpi https://updates.jenkins.io/download/plugins/configuration-as-code/1647.ve39ca_b_829b_42/configuration-as-code.hpi
## to finish 

# "Installing Jenkins Plugin Manager Tool"
sudo mkdir -p tools
sudo wget https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.12.13/jenkins-plugin-manager-2.12.13.jar
sudo java -jar jenkins-plugin-manager-2.12.13.jar --plugin-download-directory /var/lib/jenkins/plugins --plugins credentials-binding  timestamper ws-cleanup workflow-aggregator github-branch-source git ssh-slaves

#Disable setup wizard at first jenkins launch
## to finish
# echo "JAVA_ARGS=\"-Djenkins.install.runSetupWizard=false\"" >> /etc/default/jenkins

# cd /var/lib/jenkins/
# sudo mkdir -p init.groovy.d
# cd init.groovy.d

# code="#!groovy
# import jenkins.model.*
# import hudson.util.*;
# import jenkins.install.*;
# def instance = Jenkins.getInstance()
# instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)"

# Create the file and add the code
# echo "$code" > /var/lib/jenkins/init.groovy.d/basic-security.groovy

sudo systemctl restart jenkins

echo "Password"
JENKINSPWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
echo $JENKINSPWD

#Listen to github webhook call
relay forward --bucket github-jenkins

#/var/lib/jenkins/