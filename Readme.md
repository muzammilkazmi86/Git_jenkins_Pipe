# Capstone Udacity Project

## Initialization of EC2 Instance
1. Initialize an EC2 Ubuntu Instance which will act as a node to configure your project
2. Inside the instance run the commands below to give the instance ability to load virtual environment:
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install python3-venv
3. Install Docker:
    sudo apt install docker.io
4. Initialize virtual Environment: python3 -m venv venv  
5. Check which Python instance using: which python3
6. Activate virtual env: source venv/bin/activate
7. Check which Python instance to make sure it is showing the venv: which python3
8. Goto the directory where the project is stored
9. Run Make Install from the git cloned repo on the ec2 instance to download the pre-reqs


## Configuring AWS CLI
1. aws configure
    AWS Access Key ID [None]: EXMAMPLEKEYID
    AWS Secret Access Key [None]: EXAMPLEKEYACCESSID
    Default region name [None]: us-east-2
    Default output format [None]: text

## Configure EKSCTL
1.  Configure eksctl as we will be using AWS Elastic Kubernetes Service:
2. To install or upgrade eksctl on Linux using curl:
      Download and extract the latest release of eksctl with the following command.
      curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
3. Move the extracted binary to /usr/local/bin.
      sudo mv /tmp/eksctl /usr/local/bin
4. Test that your installation was successful with the following command.
      eksctl version

## Install Jenkins:
1. Commands below show a sample of how to install Jenkins:
    sudo apt-get update
    sudo apt install -y default-jdk
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt-get update
2. Ensure inbound port 8080 is allowed access to be able to bring up Jenkins. To login to jenkins use URL/IP followed by ":8080"
3. Install required plugins in Jenkins:
    Blue Ocean
    Pipeline AWS steps
    Kubernetes
4. Configure Docker credentials. Since we are using ID dockerhub, configure the credentials accordingly. (Ensure credentials plugin is installed in jenkins)
5. Configure AWS credentials within Jenkins
6. Configure blueocean to connect to Github. 

# Pipeline result once the run is successful. (Image PIPELINEFINAL)

# Sample log folder 
## This folder shares logs from different steps showing completion:
 1. 
 2. 
 3.
 4. 
 5.
 6.
 
 
# MCU Cluster deployment (mcuclusterdeployment imageE)
