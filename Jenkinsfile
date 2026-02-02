
pipeline {
    agent any
	
	environment {
		DOCKER_DEV_REPO = '569730/dev'
		DOCKER_PROD_REPO = '569730/prod'
	}
    stages {
		stage("Checkout") {
            steps {
				echo "cloning the repository"
                checkout scm
            }
        }
        stage("Build") {
            steps {
				script {
					def imageTag = (env.BRANCH_NAME == 'dev') ? "${DOCKER_DEV_REPO}:latest" : "${DOCKER_PROD_REPO}:latest"
					docker.build(imageTag)
                }
            }
        }
        stage("Push to docker hub") {
            steps {
				script {
					def imageTag = (env.BRANCH_NAME == 'dev') ? "${DOCKER_DEV_REPO}:latest" : "${DOCKER_PROD_REPO}:latest"
					docker.withRegistry('https://index.docker.io/v1/', 'dockerhubCreds') {
						docker.image(imageTag).push()
					}
				}
            }
        }
	}	
    post {
        success {
            echo "Build, push, and deploy completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs."
        }
    }
}
