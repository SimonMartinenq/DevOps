#!/bin/bash
echo "Adding apt-keys"
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Updating apt"
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update && sudo apt-get upgrade

echo "Installing java"
sudo apt install -y openjdk-17-jre
java -version

echo "Installing git"
sudo apt install -y git

echo "Installing git-ftp"
sudo apt install -y git-ftp

echo "Installing nodejs and npm"
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs

echo "Installing webhookRelay and log into" 
curl https://my.webhookrelay.com/webhookrelay/downloads/install-cli.sh | bash
relay login -k e6ebbe7b-ce2c-4871-9b8b-44bf0a87ca44 -s QNvQI8oRpDK2

echo "Installing jenkins"
sudo apt install -y --allow-unauthenticated jenkins
sudo service jenkins start


echo #Copy JCasC config file into vm
cp /vagrant/jenkins.yaml /var/lib/jenkins/jenkins.yaml

echo #Copy pipeline script into vm
cp /vagrant/seedjob.groovy /usr/local/seedjob.groovy


echo "Installing Jenkins Config as Code plugin"
sudo curl -fsSLo /var/lib/jenkins/plugins/configuration-as-code.hpi https://updates.jenkins.io/download/plugins/configuration-as-code/1647.ve39ca_b_829b_42/configuration-as-code.hpi


echo "Installing Jenkins Plugin Manager Tool"
sudo mkdir -p tools
sudo wget https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.12.13/jenkins-plugin-manager-2.12.13.jar
sudo java -jar jenkins-plugin-manager-2.12.13.jar --plugin-download-directory /var/lib/jenkins/plugins --plugins credentials-binding  timestamper ws-cleanup workflow-aggregator github-branch-source git ssh-slaves matrix-auth configuration-as-code docker-plugin job-dsl docker-workflow

echo "export JENKINS_ADMIN_ID='jenkins'" > /etc/profile.d/myvar.sh
echo "export JENKINS_ADMIN_PASSWORD='password'" >> /etc/profile.d/myvar.sh


sed -i 's|^\(JAVA_ARGS="-Djava.awt.headless=true"\)$|JAVA_ARGS="-Djava.awt.headless=true -Djenkins.install.runSetupWizard=false"|' /etc/default/jenkins

cd /var/lib/jenkins/
sudo mkdir -p init.groovy.d
cd init.groovy.d

code="#!groovy
import jenkins.model.*
import hudson.util.*;
import jenkins.install.*;

def instance = Jenkins.getInstance()

instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)"


# Create the file and add the code
echo "$code" > /var/lib/jenkins/init.groovy.d/basic-security.groovy
sudo systemctl restart jenkins


echo "Password"
JENKINSPWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
echo $JENKINSPWD

relay forward --bucket github-jenkins

#/var/lib/jenkins/