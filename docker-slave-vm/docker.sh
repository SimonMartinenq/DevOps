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

# Define the new ExecStart value
new_exec_start="ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock"

# Use sed to replace the ExecStart line in the docker.service file
sed -i "s|^ExecStart=/usr/bin/dockerd.*|$new_exec_start|" /lib/systemd/system/docker.service

# Reload the systemd daemon to apply the changes
systemctl daemon-reload

# Restart the Docker service for the changes to take effect
systemctl restart docker

# Pull docker slave image from dockerhub
sudo docker pull pierre15602/jenkins-slave-docker:latest

# Add user jenkins to the image
sudo adduser --quiet jenkins

# Set password for the jenkins user
echo "jenkins:password" | sudo chpasswd

# Create the .m2 directory for the jenkins user
sudo mkdir -p /home/jenkins/.m2

# Give jenkins user root privileges through sudo without password
echo "jenkins ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/jenkins