# React.js E-commerce Application

## Prerequisites
- AWS Account
- GitHub Repository: https://github.com/sriram-R-krishnan/devops-build

Submission Links:
- http://13.220.122.2:8080/login
- http://13.220.122.2:3001/dashboard

Docker image name: 569730/dev:latest

---

## Stage 1: Launch EC2 Instance
1. Launch EC2 Instance:
   - Go to AWS Console > EC2 > Launch Instance.
   - Choose Ubuntu 20.04 LTS, t3.micro (free tier).
   - Configure security group to allow SSH (22) and HTTP (80, 8080).
   - Launch and connect via SSH.

Clone your repository:
```bash
git clone https://github.com/sriram-R-krishnan/devops-build
```

---

## Stage 2: Bash Scripting
- Write `build.sh` and `deploy.sh` scripts.  
- Include Docker install commands and Docker Compose commands.  
- These scripts will build the Docker image and run the container.

---

## Stage 3: Version Control
```bash
git init
git remote -v
git remote remove  https://github.com/shreya-yeole/devops-build.git
git remote remove origin
git remote add origin 
git add .
git commit -m "add"
git checkout -b dev
git push -u origin dev
```

Merging dev branch to main:
```bash
git pull origin dev
git checkout main
git merge dev
git add .
git commit -m "add"
git push origin main
```

---

## Stage 4: Docker Hub
- Login to Docker Hub
- Create two repositories: `dev` and `prod`

---

## Stage 5: Jenkins
```bash
sudo apt update
sudo apt install fontconfig openjdk-21-jre
java -version
```

Install Jenkins:
```bash
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
```

Get Jenkins initial password:
```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Add Jenkins to Docker group:
```bash
sudo usermod -aG docker jenkins
```

Expose port 8080 in inbound rules.  
- Write a Jenkinsfile and push it to GitHub.  
- Add a webhook in GitHub project settings and test the connection.  
- Create a multibranch pipeline project in Jenkins, add description, GitHub URL, save.  
- Commit changes to GitHub repo → build on `dev` branch will trigger automatically.

---

## Stage 6: AWS Deployment
Launch EC2 Instance:
- Ubuntu 20.04 LTS, t2.micro (free tier)
- Allow SSH (22), HTTP (80, 8080)

Install Docker, then pull the image pushed via Jenkins pipeline:
```bash
docker login
docker pull 569730/dev:latest
docker run -d -p 8080:8080 569730/dev:latest
docker ps
```

---

## Stage 7: Monitoring
Install Uptime Kuma:
```bash
docker run -d --restart=always -p 3001:3001 -v uptime-kuma:/app/data --name uptime-kuma louislam/uptime-kuma:1
```

- Add new monitor → provide project URL  
- Add notification via Email SMTP  
- Test email connection → add connection  
- Application status visible in Uptime Kuma dashboard
```

