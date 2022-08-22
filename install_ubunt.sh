#! /bin/bash
sudo yum update -y
sudo yum install -y amazon-linux-extras
sudo yum install python3-pip -y
sudo yum install docker -y
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose 
sudo docker-compose version
sudo systemctl enable docker
sudo systemctl restart docker
sudo systemctl enable docker.service
sudo usermod -a -G docker ec2-user
sudo python3 -m pip install docker-compose
sudo mkdir appChallenge
cd /appChallenge/
sudo curl -s -O "https://x-access-token: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@raw.githubusercontent.com/Carlmontes1608/Apirest_redis/main/requirements.txt"
sudo curl -s -O "https://x-access-token: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@raw.githubusercontent.com/Carlmontes1608/Apirest_redis/main/docker-compose.yml"
sudo curl -s -O "https://x-access-token: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@raw.githubusercontent.com/Carlmontes1608/Apirest_redis/main/Dockerfile"
sudo /usr/local/bin/docker-compose up -d
sudo echo ${AWS::Region}
sudo echo "The page was created by the user data" 
 