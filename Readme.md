# Capstone Udacity Project

## 1. Project Flow:
1. Lauch a EC2 instance (Ubuntu).
2. Go thru the initialization steps under Step 2.
3. Make Install will trigger most of the dependency install.
4. Configure EKSCTL.
5. Install Jenkins by following Step 5.
    Kubernetes
Build pipeline
Docker containers
Kubernetes cluster


## 2. Initialization of EC2 Instance
1. Initialize an EC2 Ubuntu Instance which will act as a node to configure your project
2. Inside the instance run the commands below to give the instance ability to load virtual environment.
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
9. Run Make Install from the git cloned repo on the ec2 instance to download the pre-reqs. Before running Make Install, developers should clone this repository to their EC2 instance.


## 3. Configuring AWS CLI
1. aws configure
    AWS Access Key ID [None]: EXMAMPLEKEYID
    AWS Secret Access Key [None]: EXAMPLEKEYACCESSID
    Default region name [None]: us-east-2
    Default output format [None]: text

## 4. Configure EKSCTL
1.  Configure eksctl as we will be using AWS Elastic Kubernetes Service:
2. To install or upgrade eksctl on Linux using curl:
      Download and extract the latest release of eksctl with the following command.
      curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
3. Move the extracted binary to /usr/local/bin.
      sudo mv /tmp/eksctl /usr/local/bin
4. Test that your installation was successful with the following command.
      eksctl version

## 5. Install Jenkins:
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
## 6. Lint Check:
To verify linting, change the html code purposely and run the pipeline thru. Failure will look somewhat similar to the screenshot below:
![Linting check](https://github.com/muzammilkazmi86/Capstone_Udacity/blob/master/image/verifylinting.png)

## 7. Pipeline result once the run is successful.
![Successful pipeline](https://github.com/muzammilkazmi86/Capstone_Udacity/blob/master/image/PIPELINEFINAL.png)
## 8. Sample log folder 
This folder shares logs from different steps in the pipeline. 

## 9. MCU Cluster deployment
Below shows successful cluster deployment:
![Cloudformation Result](https://github.com/muzammilkazmi86/Capstone_Udacity/blob/master/image/mcuclustercloudformation.png)
![Cluster Result](https://github.com/muzammilkazmi86/Capstone_Udacity/blob/master/image/mcuclusterdeployment.png)

## 10. Website result:
![Website Result](https://github.com/muzammilkazmi86/Capstone_Udacity/blob/master/image/webpage%20result.png)


## 11. Bonus Tip (Checking your cluster from the EC2 Node running Jenkins):
1. Create a kubectl configuration file in your ~/.kube directory as ~/.kube/config-eks:
    mkdir ~/.kube
    touch ~/.kube/config-eks
2. Fill the file with the following contents, replacing the placeholders shown as follows:
     - Replace API-SERVER-ENDPOINT: API server endpoint obtained from the cluster.
     - Replace CA-DATA: certificate authority data obtained from the cluster.
     - Replace CLUSTER-NAME: name of AWS EKS cluster.
     - Replace PROFILE-NAME: AWS credentials profile from the ~/.aws/credentials file (typically, default).

```sh
        apiVersion: v1
    clusters:
    - cluster:
        server: API-SERVER-ENDPOINT
        certificate-authority-data: CA-DATA
      name: kubernetes
    contexts:
    - context:
        cluster: kubernetes
        user: aws
      name: aws
    current-context: aws
    kind: Config
    preferences: {}
    users:
    - name: aws
      user:
        exec:
          apiVersion: client.authentication.k8s.io/v1alpha1
          command: heptio-authenticator-aws
          args:
            - "token"
            - "-i"
            - "CLUSTER-NAME"
          env:
            - name: AWS_PROFILE
              value: "PROFILE-NAME"
```
3. Add the file to the $KUBECONFIG environment variable so that kubectl is able to find it:
    export KUBECONFIG=~/.kube/config-eks
4. To check if you can successfully connect, run: kubectl get svc
