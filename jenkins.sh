#!/bin/bash
echo "Adding apt-keys"
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

echo "Updating apt-get"
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get upgrade -y

echo "Installing java"
sudo apt-get install -y openjdk-11-jre openjdk-11-jdk
java -version

echo "Installing git"
sudo apt-get -y install git

echo "Installing git-ftp"
sudo apt-get -y install git-ftp

echo "Installing node js"
sudo apt-get install -y nodejs

echo "Installing jenkins"
sudo apt-get install -y --allow-unauthenticated jenkins
sudo service jenkins start

echo "Password"
JENKINSPWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
echo $JENKINSPWD