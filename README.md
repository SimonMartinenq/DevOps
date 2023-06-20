# DevOps

LAB 1 : 
- Install Oracle VM Virtual Box and vagrant 
- Create a folder and put into the folder the Vagrantfile and the jenkins.sh
- Go into your CMD at the place of your new folder and run :
    - vagrant up
    - vagrant ssh
    - sudo add-apt-repository ppa:openjdk-r/ppa
    - sudo apt-get update
    - sudo apt-get install openjdk-11-jdk
- To check that your installation is good do : systemctl status jenkins. If jenkins is active go on localhost:8080
- Then follow the section "Configuring Jenkins" of the website : https://rdarida.medium.com/installing-jenkins-on-localhost-with-vagrant-8aa59761bec

