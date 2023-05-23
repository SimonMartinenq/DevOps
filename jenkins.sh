#!/bin/bash
echo "Adding apt-keys"
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list

echo "Updating apt-get"
sudo apt-get -qq update

echo "Installing default-java"
sudo apt-get -y install default-jre 
sudo apt-get -y install default-jdk 

echo "Installing git"
sudo apt-get -y install git 

echo "Installing git-ftp"
sudo apt-get -y install git-ftp 

echo "Installing jenkins"
sudo apt-get -y install jenkins > 
sudo service jenkins start

sleep 1m

echo "Installing Jenkins Plugins"
JENKINSPWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
echo $JENKINSPWD