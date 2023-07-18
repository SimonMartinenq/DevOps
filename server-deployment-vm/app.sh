# Set up the repository
echo "Setting up the repository"
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
echo "Installing Docker"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install a basic SSH server
sudo apt-get install -qy openssh-server
sudo sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
sudo mkdir -p /var/run/sshd
echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Add user jenkins to the image
sudo adduser --quiet jenkins 
# Set password for the jenkins user (you may want to alter this).
echo "jenkins:password" | chpasswd && \
sudo mkdir /home/jenkins/.m2
visudo -f /etc/sudoers.d/jenkins <<< "jenkins ALL=(ALL) NOPASSWD: ALL"


# Reload and restart the docker service
sudo systemctl daemon-reload
sudo service docker restart
