# Add Docker’s official GPG key:
echo -e "\n==== Adding Docker GPG key ====\n"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Use the following command to set up the repository:
echo -e "\n==== Setting up Docker repo ====\n"
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine, containerd, Docker Compose & Update the apt package index:
echo -e "\n==== Installing Docker engine and updating apt package ====\n"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Build the docker image
echo -e "\n==== Building Docker image ====\n"
sudo docker build --platform linux/amd64 -t doze-nginx .
