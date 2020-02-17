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
		withAWS(credentials: 'jenkins', region: 'us-east-2a') {
		    sh 'echo "Create kubernetes cluster..."'
		    sh '''
			eksctl create cluster \
			--name mcu \
			--version 1.14 \
			--region us-east-2 \
			--nodegroup-name standard-workers \
			--node-type t2.micro \
			--nodes 2 \
			--nodes-min 1 \
			--nodes-max 4 \
			--managed
		'''
		}
	    }
        }
	    
	stage('Configure kubectl') {
	    steps {
		withAWS(credentials: 'jenkins', region: 'us-east-2a') {
		    sh 'echo "Configure kubectl..."'
		    sh 'aws eks --region us-east-2 update-kubeconfig --name udacity' 
		}
	    }
        }

	stage('Deploy blue container') {
	    steps {
		withAWS(credentials: 'jenkins', region: 'us-east-2a') {
		    sh 'echo "Deploy blue container..."'
		    sh 'kubectl apply -f ./blue/blue.yaml'
		}
	    }
	}
	    
	stage('Deploy green container') {
	    steps {
		withAWS(credentials: 'jenkins', region: 'us-east-2a') {
		    sh 'echo "Deploy green container..."'
		    sh 'kubectl apply -f ./green/green.yaml'
		}
	    }
	}
	    
	stage('Create blue service') {
	    steps {
		withAWS(credentials: 'jenkins', region: 'us-east-2a') {
		    sh 'echo "Create blue service..."'
		    sh 'kubectl apply -f ./blue/blue_service.yaml'
		}
	    }
	}
	    
	stage('Update service to green') {
	    steps {
		withAWS(credentials: 'jenkins', region: 'us-east-2a') {
		    sh 'echo "Update service to green..."'
		    sh 'kubectl apply -f ./green/green_service.yaml'
		}
	    }
	}	
   }   
	    
}
