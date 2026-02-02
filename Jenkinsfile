
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
					def imageTag = "${env.BRANCH_NAME}-${env.BUILD_ID}"
					docker.build(imageTag)
                }
            }
        }
        stage("Push to docker hub") {
            steps {
				script {
					docker.withRegistry('https://index.docker.io/v1/', 'dockerhubCreds') {	
						if (env.BRANCH_NAME == 'dev') {
							docker.image("${DOCKER_DEV_REPO}:${env.BUILD_ID}").push()
						} else if (env.BRANCH_NAME == 'main') {
							docker.image("${DOCKER_PROD_REPO}:${env.BUILD_ID}").push()
						}
					}
				}
            }
        }
	}	
    post {
        success {
            echo "✅ Build, push, and deploy completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs."
        }
    }
}
