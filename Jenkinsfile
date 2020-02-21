pipeline {
    agent any
    stages {
        stage('Lint HTML') {
            steps {
		sh 'echo "Performing lint check"'
                sh 'tidy -q -e *.html'
            }
        }
	    
	stage('Build Docker Image') {
   	    steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]){
		    sh 'echo "Deploying Docker Image..."'
     	    	    sh 'docker build -t muzammilkazmi86/capstone .'
		}
            }
        }
	    
	stage('Push Image To Dockerhub') {
   	    steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]){
		    sh 'echo "Image push for Docker Image..."'
     	    	    sh '''
                        docker login -u $USERNAME -p $PASSWORD
			docker push muzammilkazmi86/capstone
                    '''
		}
            }
        }
	    
	stage('Create kubernetes cluster') {
	    steps {
		withAWS(credentials: 'aws-kubectl', region: 'us-east-2') {
		    sh 'echo "Create kubernetes cluster..."'
		    sh '''
			eksctl create cluster \
			--name mcu \
			--version 1.14 \
			--region us-east-2 \
			--nodegroup-name standard-workers \
			--nodeImageId ami-080fbb09ee2d4d3fa \
			--node-type t2.micro \
			--role-arn arn:aws:iam::322886847718:role/eks \
			--resources-vpc-config subnetIds=subnet-076514427d9f7655d,subnet-0514b9a5e9d47840f,subnet-0489962ecb83961dc,securityGroupIds=sg-04ebd0c7c098557d1 \
			--keyname capstone \
			--VpcId vpc-0ecbd4a94757c33e6 \
			--nodes 2 \
			--nodes-min 1 \
			--nodes-max 3 \
			--managed
		
		'''
		}
	    }
        }
	    
	stage('Configure kubectl') {
	    steps {
		withAWS(credentials: 'aws-kubectl', region: 'us-east-2') {
		    sh 'echo "Configure kubectl..."'
		    sh 'aws eks --region us-east-2 update-kubeconfig --name mcu' 
		}
	    }
        }

	stage('Deploy blue container') {
	    steps {
		withAWS(credentials: 'aws-kubectl', region: 'us-east-2') {
		    sh 'echo "Deploy blue container..."'
		    sh 'kubectl apply -f ./Blue/blue.yaml'
		}
	    }
	}
	    
	stage('Deploy green container') {
	    steps {
		withAWS(credentials: 'aws-kubectl', region: 'us-east-2') {
		    sh 'echo "Deploy green container..."'
		    sh 'kubectl apply -f ./Green/green.yaml'
		}
	    }
	}
	    
	stage('Create blue service') {
	    steps {
		withAWS(credentials: 'aws-kubectl', region: 'us-east-2') {
		    sh 'echo "Create blue service..."'
		    sh 'kubectl apply -f ./Blue/blue_service.yaml'
		}
	    }
	}
	    
	stage('Update service to green') {
	    steps {
		withAWS(credentials: 'aws-kubectl', region: 'us-east-2') {
		    sh 'echo "Update service to green..."'
		    sh 'kubectl apply -f ./Green/green_service.yaml'
		}
	    }
	}	
   }   
	    
}
